terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "core" {
  name     = "${var.name_prefix}-rg"
  location = var.location

  tags = var.default_tags
}

resource "azurerm_storage_account" "artifacts" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = azurerm_resource_group.core.name
  location                 = azurerm_resource_group.core.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true

  tags = merge(var.default_tags, {
    Component = "artifacts"
  })
}

resource "azurerm_storage_container" "state" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.artifacts.name
  container_access_type = "private"
}

output "resource_group_name" {
  description = "Name of the resource group hosting the shared resources."
  value       = azurerm_resource_group.core.name
}

output "storage_account_name" {
  description = "Name of the storage account used for Terraform state and artifacts."
  value       = azurerm_storage_account.artifacts.name
}
