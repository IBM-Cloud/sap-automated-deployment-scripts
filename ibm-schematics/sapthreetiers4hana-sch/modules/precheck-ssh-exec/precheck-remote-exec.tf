resource "null_resource" "check-bastion-resources" {

        connection {
            type = "ssh"
            user = "root"
            host = var.BASTION_FLOATING_IP
            private_key = var.private_ssh_key
            timeout = "1m"
         }

         provisioner "file" {
           source      = "modules/precheck-ssh-exec/check_file.sh"
           destination = "/tmp/check_file-${var.HOSTNAME}.sh"
         }

         provisioner "remote-exec" {
           inline = [
             "chmod +x /tmp/check_file-${var.HOSTNAME}.sh",
             "dos2unix /tmp/check_file-${var.HOSTNAME}.sh",
           ]
         }


         provisioner "file" {
           source      = "modules/precheck-ssh-exec/error.sh"
           destination = "/tmp/${var.HOSTNAME}.error.sh"
         }

         provisioner "remote-exec" {
           inline = [
             "chmod +x /tmp/${var.HOSTNAME}.error.sh",
             "dos2unix /tmp/${var.HOSTNAME}.error.sh",
           ]
         }

         provisioner "file" {
           source      = "modules/precheck-ssh-exec/sap-paths-${var.HOSTNAME}"
           destination = "/tmp/sap-paths-${var.HOSTNAME}"
         }


         provisioner "remote-exec" {
             inline = [
              "for i in `cat /tmp/sap-paths-${var.HOSTNAME}`; do  /tmp/check_file-${var.HOSTNAME}.sh $i; done > /tmp/${var.HOSTNAME}.precheck.log",
            ]
         }

    }


  resource "null_resource" "check-path-errors" {

         depends_on	= [ null_resource.check-bastion-resources ]

         provisioner "local-exec" {
             command = "ssh -o 'StrictHostKeyChecking no' -i ansible/id_rsa root@${var.BASTION_FLOATING_IP} 'export HOSTNAME=${var.HOSTNAME}; timeout 5s /tmp/${var.HOSTNAME}.error.sh'"
             on_failure = fail
         }

     }
