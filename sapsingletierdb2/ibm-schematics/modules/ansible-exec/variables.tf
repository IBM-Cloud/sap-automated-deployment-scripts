variable "BASTION_FLOATING_IP" {
    type = string
    description = "IP used to execute the remote script"
}

variable "IP" {
    type = string
    description = "IP used by ansible"
}

variable "private_ssh_key" {
    type = string
    description = "Private ssh key"
}
