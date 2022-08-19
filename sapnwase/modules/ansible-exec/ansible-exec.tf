resource "null_resource" "ansible-exec" {

  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.IP}, ansible/sapnwase.yml"
  }

  # provisioner "local-exec" {
  #    command = "sed -i  's/${var.sap_main_password}/xxxxxxxx/' terraform.tfstate"
  #   }

  # provisioner "local-exec" {
  #      command = "sleep 20; rm -rf  ansible/*-vars.yml"
  #     }
}
