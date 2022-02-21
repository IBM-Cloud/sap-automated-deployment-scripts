resource "null_resource" "install-prereq" {

provisioner "file" {
  source      = "modules/install-prereq/prereq.sh"
  destination = "/tmp/prereq.sh"
}

connection {
    type = "ssh"
    user = "root"
    host = var.IP
#    private_key = "${file("modules/install-prereq/id_rsa")}"
     private_key = var.private_ssh_key
 }

provisioner "remote-exec" {
  inline = [
    "chmod +x /tmp/prereq.sh",
    "/tmp/prereq.sh args",
  ]
}

}
