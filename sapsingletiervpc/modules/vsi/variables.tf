variable "ZONE" {
    type = string
    description = "Cloud Zone"
}

variable "VPC" {
    type = string
    description = "VPC name"
}

variable "SUBNET" {
    type = string
    description = "Subnet name"
}

variable "SECURITYGROUP" {
    type = string
    description = "Security group name"
}

variable "HOSTNAME" {
    type = string
    description = "VSI Hostname"
}

variable "PROFILE" {
    type = string
    description = "VSI Profile"
}

variable "IMAGE" {
    type = string
    description = "VSI OS Image"
}

variable "SSH_KEYS" {
    type = list(string)
    description = "List of SSH Keys to access the VSI"
}

variable "VOLUMES_LIST" {
    type = list(string)
    description = "List of volumes"
}

