resource "local_file" "my_terraform_file" {
  content  = "${data.local_file.introduction.content} to ${random_pet.pet[1].id}"
  filename = "./helloWorld.txt"
}

resource "random_pet" "pet" {
  count = 2
}

data "local_file" "introduction" {
  filename = "./introduction.txt"
}

resource "local_file" "my_terraform_file2" {
  content  = "${random_pet.pet[0].id}"
  filename = "./helloWorld2.txt"
}