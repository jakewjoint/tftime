terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "sharedservicesdevstate"
    container_name       = "tfstate"
    key                  = "jakej10.terraform.tfstate"
  }
}

module "generateRandomFiles" {
  source      = "./randomfiles"
  count       = 2
  folder_name = "my_folder"
}
