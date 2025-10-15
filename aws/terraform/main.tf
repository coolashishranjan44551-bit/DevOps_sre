
terraform {
  required_version = ">= 1.5.0"
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

# Example: tagged S3 bucket (name derived from env/project)
resource "aws_s3_bucket" "example" {
  bucket = "${var.project}-${var.environment}-tf-example-${random_id.suffix.hex}"
  tags = var.tags
}

resource "random_id" "suffix" {
  byte_length = 2
}
