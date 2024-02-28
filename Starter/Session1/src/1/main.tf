resource "local_file" "my_terraform_file" {
  content  = "La souris est en "
  filename = "./hellonotWorld.txt"
}