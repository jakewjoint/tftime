resource "random_string" "filename" {
  length  = 6
  special = false
}

resource "local_file" "my_terraform_file" {
  content  = "La souris est en dessous de la table - The mouse is under the table."
  filename = "./${var.folder_name}/${random_string.filename.result}.txt"
}
