resource "random_string" "filename" {
  length  = 6
  special = false
}

resource "local_file" "my_terraform_file" {
  content  = "${var.content}"
  filename = "./${var.folder_name}/${random_string.filename.result}.txt"
}
