variable "location" {
  description = "Azure region to deploy resources into."
  type        = string
  default     = "eastus"
}

variable "name_prefix" {
  description = "Prefix added to Azure resource names."
  type        = string
  default     = "devops-sre"
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account."
  type        = string
  default     = "devopssreartifacts"
}

variable "default_tags" {
  description = "Common tags applied to Azure resources."
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Project     = "devops-sre"
  }
}