resource "local_file" "my_terraform_file" {
  content  = "${data.local_file.introduction.content} to ${random_pet.pet.id}"
  filename = "./${var.filename}.txt"
}

resource "random_pet" "pet" {
}

data "local_file" "introduction" {
  filename = "./introduction.txt"
}
