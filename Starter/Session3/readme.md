# Terraform Time

## Week Three

- Modules
- State Management

### Create a module that generates a random file (1)

Outcome: Get a basic module which creates a random file

- Create a folder within your TF solution
- Within that folder, create a `main.tf` with a `random_string` and `random_resource` that creates a file with random file name
  - Could also create random content
- From the "top" folder, create a `main.tf` and invoke the module

### Create a specified number random files in a specified folder (2)

Outcome: Using a module to create multiples of the same resource

- Use count to make multiple of the module
- Using an input into the module, specify which folder the files are created in
  - https://developer.hashicorp.com/terraform/language/values/variables
- Using outputs, output the path to the files
  - https://developer.hashicorp.com/terraform/language/values/outputs
- (optional, generate random content or pass it in to the module)

### Store Terraform State in a central location (3)

Outcome: Use the backend state feature of Terraform to store our state in an Azure Blob

- Run a `terraform destroy`
- Add a backend block to your the terraform block
  - https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
- Run `terraform apply`
- Inspect your state file which will now exist in Azure

### Creating storage accounts in Azure, again

Outcome: Create a module that creates a randomly named storage account and creates a specified number of files within that storage account containing random content. The storage accounts must be created within a specified resource group and the state must be stored in an Azure Blob
