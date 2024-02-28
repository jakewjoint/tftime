resource "local_file" "my_terraform_file" {
  content  = random_string.long.result
  filename = "./helloWorld.txt"
}