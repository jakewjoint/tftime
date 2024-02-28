# Terraform Time

## Week Two

### Create a resource group in UK South (1)

Outcome: Connect to Azure and create a resource group in UK South

- `az login`
- `az account set --subscription "SharedServices-DEV"`
- Use the example from the documentation to create a resource group
  - Name it something vaguely short and sensible and suffix with `-rg`
    - `jakej-rg`
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

### Create a storage account (2)

- Use the example from the documentation to create a storage account
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
- Reuse the "sensible" part of the name and suffix with `sa`
  - Try to give it a name containing a capital in it...
- Make sure to use implicit dependencies between resources
- Storage accounts are public by default

### Add minor refinements (3)

- Expose `location` as a input variable but set the default to "UK South"
  - What happens when you change the location to "UK West"
- Use a local variable to prevent copy and pasting the "sensible part" of the name.
  - https://developer.hashicorp.com/terraform/tutorials/configuration-language/locals?in=terraform%2Fconfiguration-language#use-locals-to-name-resources
- Make use of the "region module".
  - Modules are the nuget packages of the Terraform world (but clunkier)
  - Can refer to outputs from modules with the format `module.internal_name.output_name`
  - This module provides plan time errors and uniform short version of locations.
  - https://registry.terraform.io/modules/claranet/regions/azurerm/latest

### Serve a static webpage from the storage account (4)

- Enable static website on the storage account
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#static_website
- Create a index.html blob in `$web` with your content
  - `Content_type` should be `"text/html"`
  - Use `source_content` to manually set the content of the file for the moment
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob
- Create a output variable of the URL where the page is accessible.
  - The storage account object has a property called `primary_web_endpoint`. hint hint.
- Bonus points
  - Create a `index.html` file locally and upload it to the blob store
  - Using the `network_rules` block only allow the storage account to be access from your IP address
    - https://icanhazip.com/
    - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#network_rules

### Create a publicly accessible VM (5)

This is a TERRIBLE thing to do and should never be done but these are going to be short lived for demo purposes. You should never allow public access directly to a VM and if you do it, you should have security rules applied to it.

- Create a VM which you can RDP on to, you need:
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
    - The subnet should be associated to the above VNet
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip
    - This is the IP you will use to RDP onto
    - Have a static allocation method
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
    - This is the "network card" for the VM. It needs to know the `Subnet id` and the `public ip id` in the `ip_configuration` block
  - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine
    - This is actual VM, the above network interface gets associated to this resource
    - Change the password to be something unique

### Useful links

- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli
- https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
- https://developer.hashicorp.com/terraform/language/expressions
- https://developer.hashicorp.com/terraform/language/functions
- https://cloud.google.com/docs/terraform/best-practices-for-terraform

### Additional topics

Terraform fmt
Terraform validate
Keepers
HCL lock