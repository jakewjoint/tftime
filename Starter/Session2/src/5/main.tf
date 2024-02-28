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

resource "azurerm_virtual_network" "main" {
  name                = "${local.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "vm" {
  name                 = "${local.prefix}-vm-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "vm" {
  name                = "${local.prefix}-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "vm" {
  name                = "${local.prefix}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "external"
    public_ip_address_id          = azurerm_public_ip.vm.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vm.id
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${local.prefix}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "ThisIsAR3allySeurceP@ssword01."
  network_interface_ids = [
    azurerm_network_interface.vm.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }



  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

output "pip"{
  value = resource.azurerm_public_ip.vm.ip_address
}

