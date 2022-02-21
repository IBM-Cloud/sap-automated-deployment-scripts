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

variable "ADD_OPEN_PORTS_IN_NEW_SUBNET" {
    type = string
    description = "New open ports"
}

variable "OPEN_PORT_MINIMUM" {
	type		= number
	description = "(Required, Integer) The TCP port range that includes the minimum bound. Valid values are from 1 to 65535."
}

variable "OPEN_PORT_MAXIMUM" {
	type		= number
	description = "(Required, Integer) The TCP port range that includes the maximum bound. Valid values are from 1 to 65535."
}
