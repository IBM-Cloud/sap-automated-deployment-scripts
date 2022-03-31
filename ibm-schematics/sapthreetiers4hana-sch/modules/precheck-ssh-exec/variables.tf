variable "BASTION_FLOATING_IP" {
    type = string
    description = "IP used to execute the remote script"
}

variable "HOSTNAME" {
    type = string
    description = "VSI Hostname"
}

variable "private_ssh_key" {
    type = string
    description = "Private ssh key"
}
