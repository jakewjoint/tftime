terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  prefix = "jakej"
}

module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "6.0.0"

  azure_region = var.location # https://registry.terraform.io/modules/claranet/regions/azurerm/6.0.0?utm_content=documentLink&utm_medium=Visual+Studio+Code&utm_source=terraform-ls#outputs
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = module.azure_region.location
}

resource "azurerm_storage_account" "example" {
  name                     = "${local.prefix}sa"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
