resource "null_resource" "ansible-exec" {

    connection {
      type = "ssh"
      user = "root"
      host = var.BASTION_FLOATING_IP
      private_key = var.private_ssh_key
    }

    provisioner "file" {
      source      = "ansible"
      destination = "/tmp/ansible.sapsingletierdb2-${var.IP}"
    }

    provisioner "file" {
      source      = "modules/ansible-exec/while.sh"
      destination = "/tmp/${var.IP}.while.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/${var.IP}.while.sh",
      ]
    }

    provisioner "file" {
      source      = "modules/ansible-exec/error.sh"
      destination = "/tmp/${var.IP}.error.sh"
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/${var.IP}.error.sh",
      ]
    }


    provisioner "local-exec" {
         command = "chmod 600 ansible/id_rsa"
    }

    provisioner "remote-exec" {
        inline = [
         "chmod 600 /tmp/ansible.sapsingletierdb2-${var.IP}/id_rsa",
         "ssh-keyscan -H ${var.IP} >> ~/.ssh/known_hosts",
       ]
    }

    provisioner "local-exec" {
          command = "ssh -o 'StrictHostKeyChecking no' -i ansible/id_rsa root@${var.BASTION_FLOATING_IP} 'nohup ansible-playbook --private-key /tmp/ansible.sapsingletierdb2-${var.IP}/id_rsa -i ${var.IP}, /tmp/ansible.sapsingletierdb2-${var.IP}/sapnwdb2.yml > /tmp/ansible.sapsingletierdb2-${var.IP}/ansible.${var.IP}.log 2>&1 &'"
    }

}


resource "null_resource" "ansible-logs" {

    depends_on	= [ null_resource.ansible-exec ]

    provisioner "local-exec" {
          command = "ssh -o 'StrictHostKeyChecking no' -i ansible/id_rsa root@${var.BASTION_FLOATING_IP} 'export IP=${var.IP}; timeout 55m /tmp/${var.IP}.while.sh'"
          on_failure = continue
    }

}


resource "null_resource" "ansible-logs1" {

    depends_on	= [ null_resource.ansible-logs ]

    provisioner "local-exec" {
          command = "ssh -o 'StrictHostKeyChecking no' -i ansible/id_rsa root@${var.BASTION_FLOATING_IP} 'export IP=${var.IP}; timeout 55m /tmp/${var.IP}.while.sh'"
          on_failure = continue
    }

}


resource "null_resource" "ansible-errors" {

    depends_on	= [ null_resource.ansible-logs1 ]

    provisioner "local-exec" {
          command = "ssh -o 'StrictHostKeyChecking no' -i ansible/id_rsa root@${var.BASTION_FLOATING_IP} 'export IP=${var.IP}; timeout 5s /tmp/${var.IP}.error.sh'"
          on_failure = fail
    }

}


resource "null_resource" "ansible-delete-sensitive-data" {

    depends_on	= [ null_resource.ansible-logs1 ]

    connection {
        type = "ssh"
        user = "root"
        host = var.BASTION_FLOATING_IP
        private_key = var.private_ssh_key
     }

    provisioner "remote-exec" {
        inline = [ "rm -rf /tmp/ansible.sapsingletierdb2-${var.IP}" ]
     }

}
