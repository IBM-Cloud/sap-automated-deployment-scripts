resource "null_resource" "ansible-exec" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.IP}, ${var.PLAYBOOK_PATH}"
  }
}
