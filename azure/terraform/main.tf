
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

# Example: Resource Group
resource "azurerm_resource_group" "example" {
  name     = "${var.project}-${var.environment}-rg"
  location = var.location
  tags     = var.tags
}
