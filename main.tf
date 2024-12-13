terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Resource Group Module
module "resource_group" {
  source              = "./modules/resource_group"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Storage Account Module
module "storage_account" {
  source                  = "./modules/storage_account"
  resource_group_name     = module.resource_group.name
  storage_account_name    = var.storage_account_name
  location                = var.location
  source_folder_name      = var.source_folder_name
  destination_folder_name = var.destination_folder_name

  depends_on = [
    module.resource_group
  ]
}

# Data Factory Module
module "data_factory" {
  source               = "./modules/data_factory"
  resource_group_name  = module.resource_group.name
  adf_name             = var.adf_name
  storage_account_name = module.storage_account.storage_account_name
  location             = var.location

  depends_on = [
    module.storage_account
  ]
}
