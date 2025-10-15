terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_ami" "bastion" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.name_prefix}-artifacts"

  tags = merge(var.default_tags, {
    Component = "artifacts"
  })
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.bastion.id
  instance_type = var.bastion_instance_type

  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}-bastion"
  })
}

output "artifact_bucket_name" {
  description = "Name of the S3 bucket storing deployment artifacts."
  value       = aws_s3_bucket.artifacts.id
}

output "bastion_instance_id" {
  description = "Identifier for the bastion instance used by operators."
  value       = aws_instance.bastion.id
}