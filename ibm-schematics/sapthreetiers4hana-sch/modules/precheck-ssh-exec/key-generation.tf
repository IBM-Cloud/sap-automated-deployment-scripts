# Export Terraform variable values to a temp id_rsa file
resource "local_file" "tf_id_rsa" {
  content = <<-DOC
${var.private_ssh_key}
    DOC
  filename = "ansible/id_rsa"
  file_permission = "0600"
}
