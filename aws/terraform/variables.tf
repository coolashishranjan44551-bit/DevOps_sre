variable "region" {
  description = "AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "name_prefix" {
  description = "Prefix added to resource names to avoid collisions."
  type        = string
  default     = "devops-sre"
}

variable "bastion_instance_type" {
  description = "Instance size for the bastion host."
  type        = string
  default     = "t3.micro"
}

variable "default_tags" {
  description = "Common tags applied to all AWS resources."
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Project     = "devops-sre"
  }
}
