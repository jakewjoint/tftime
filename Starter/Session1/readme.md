# Session One

## IaC and Terraform

- What is IaC
- What is Terraform

## Creating a resource through Terraform

Outcome: Create a local file through Terraform

- Create a folder in root of this repo with your name on it
- Create a local file using the local_file provider
  - https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
  - You can copy from: `./src/1`
  - `terraform init`
    - A one off command per project
  - `terraform plan`
  - `terraform apply`
- Change the name of the local file via terraform
  - `terraform plan`
    - It wants to replace the file, destroying the old and creating the new
  - `terraform apply`
- Change the content of the file via terraform
- Change the content of the file manually and see what happens
  - Create instead of replace, Terraform isn't magic, it is dumb

## Adding a second resource

Outcome: Create a local file through Terraform and set it's content via the Terraform random string provider

- Add a new resource which generates a random string and uses that as the content for the local file
  - https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
  - Need to reference the random string from the file resource
    - Format is "resourceType.internalName.property". See below, the aws_instance has a property called id which is automatically generated on creation
    - The property you need is in the `readonly` section of the above webpage
- Apply the terraform again, do you get a new random value?

## Use existing resources

Outcome: Create a local file through Terraform and set it's content by pulling existing content from another file and adding some random words.

- Manually create a file called `introduction.txt` with the content `hello`
- Add another new resource using the pet resource to generate a name
  - https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
  - Don't worry about the keeper stuff
- Using a file datasource, load the content file `introduction.txt`
  - https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file
- Using the string interpolation syntax, create a new file with the content from both `introduction.txt` and the `pet resource`
  - https://developer.hashicorp.com/terraform/language/expressions/strings

## Use input variables to increase flexibility

Outcome: Controlling the name of the created file so that it can be changed depending on environment

- Create a `variables.tf`
- Add a `string` input variable called `filename`
  - https://developer.hashicorp.com/terraform/language/values/variables
- Reference the variable in your Terraform
  - literal syntax is `var.filename`
- Apply your terraform
  - Manually prompted by your Terraform to enter values
- Create a `dev.tfvars` file containing `filename = "mycustomfilename"`
- Apply the terraform
  `terraform apply -var-file="dev.tfvars"`
- Optional: Create a `test.tfvars` and set a different value for filename
- Set a default value for the filename variable in your `variables.tf`

## Get outputs from Terraform

Outcome: Allow values to be exported from the terraform so they can be used elsewhere

- Add a `outputs.tf` file
- Add an output variable to expose the random pet id
  - https://developer.hashicorp.com/terraform/language/values/outputs
- Apply the terraform

### Useful links

https://developer.hashicorp.com/terraform/language/expressions
https://developer.hashicorp.com/terraform/language/functions
https://cloud.google.com/docs/terraform/best-practices-for-terraform

### Additional topics

Terraform fmt
Terraform validate
Locals
Keepers
HCL lock
