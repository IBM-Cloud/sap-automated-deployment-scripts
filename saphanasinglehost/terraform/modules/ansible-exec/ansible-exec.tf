resource "null_resource" "ansible-exec" {
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.IP}, ../ansible/saphanasinglehost.yml"
  }
  provisioner "local-exec" {
     command = "sed -i  's/${var.hana_master_password}/xxxxxxxx/' terraform.tfstate"
    }
  provisioner "local-exec" {
       command = "sleep 20; rm -rf  ../ansible/*-vars.yml"
      }
}
