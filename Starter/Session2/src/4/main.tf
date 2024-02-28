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

  azure_region = var.location
}

resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-rg"
  location = module.azure_region.location
}

resource "azurerm_storage_account" "static_web" {
  name                          = "${local.prefix}sa"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  account_tier                  = "Standard"
  account_replication_type      = "GRS"
  public_network_access_enabled = true

  static_website {
    index_document = "index.html"
  }

  network_rules {
    default_action = "Deny"
    ip_rules       = ["195.224.52.66"] # Phocle VPN
  }
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static_web.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = "Hello World"
}

output "url" {
  value = azurerm_storage_account.static_web.primary_web_endpoint
}

# resource "azurerm_storage_account_network_rules" "vpn" {
#   storage_account_id = azurerm_storage_account.static_web

#   default_action = "Allow"
#   ip_rules       = ["195.224.52.66"] # Phocle VPN
# }
