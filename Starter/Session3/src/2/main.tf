module "generateRandomFiles" {
  source      = "./randomfiles"
  count       = 2
  folder_name = "my_folder"
  content     = local.content
}


locals {
  content = "Hello to ${random_pet.pet.id}"
}

resource "random_pet" "pet" {
}