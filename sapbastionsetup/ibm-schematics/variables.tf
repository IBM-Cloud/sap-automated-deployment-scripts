variable "private_ssh_key" {
	type		= string
	sensitive = true
	description = "Input id_rsa private key content."
}

variable "SSH_KEYS" {
	type		= list(string)
	description = "SSH Keys ID list to access the VSI."
}

variable "REGION" {
	type		= string
	description	= "Cloud Region"
}

variable "ZONE" {
	type		= string
	description	= "Cloud Zone"
}

variable "VPC_EXISTS" {
	type		= string
	description = "Please mention if the chosen VPC exists or not (use 'yes' or 'no').\n If you choose 'no' as an option, a new VPC will be created."
	validation {
		condition = var.VPC_EXISTS == "yes" || var.VPC_EXISTS =="no"
		error_message = "The value for this parameter can only be yes or no."
	}
}

variable "SUBNET_EXISTS" {
	type		= string
	description = "Please mention if the chosen SUBNET/SECURITYGROUP exist or not (use 'yes' or 'no').\n If you choose 'no' as an option, a new SUBNET/SECURITYGROUP with OPEN PORTS will be created in the existing VPC."
	validation {
		condition = var.SUBNET_EXISTS == "yes" || var.SUBNET_EXISTS =="no"
		error_message = "The value for this parameter can only be yes or no."
	}
}

variable "ADD_OPEN_PORTS_IN_NEW_SUBNET" {
	type		= string
	description = "To create new port/s only if a NEW SUBNET is created, use 'yes' or 'no'."
	default		= "no"
	validation {
		condition = var.ADD_OPEN_PORTS_IN_NEW_SUBNET == "yes" || var.ADD_OPEN_PORTS_IN_NEW_SUBNET =="no"
		error_message = "The value for this parameter can only be yes or no."
	}
}

variable "OPEN_PORT_MINIMUM" {
	type		= number
	description = "(Required, Integer) The TCP port range that includes the minimum bound. Valid values are from 1 to 65535."
	default		= "3200"
	validation {
		condition = var.OPEN_PORT_MINIMUM <= 65535 && var.OPEN_PORT_MINIMUM >= 1
		error_message = "Valid values are from 1 to 65535."
	}
}


variable "OPEN_PORT_MAXIMUM" {
	type		= number
	description = "(Required, Integer) The TCP port range that includes the maximum bound. Valid values are from 1 to 65535."
	default		= "3200"
	validation {
		condition = var.OPEN_PORT_MAXIMUM <= 65535 && var.OPEN_PORT_MAXIMUM >= 1
		error_message = "Valid values are from 1 to 65535."
	}
}


variable "VPC" {
	type		= string
	description = "VPC name"
}


variable "SUBNET" {
	type		= string
	description = "Subnet name"
}

variable "SECURITYGROUP" {
	type		= string
	description = "Security group name"
}

variable "HOSTNAME" {
	type		= string
	description = "VSI Hostname"
}

variable "PROFILE" {
	type		= string
	description = "VSI Profile"
	default		= "bx2-4x16"
}

variable "IMAGE" {
	type		= string
	description = "VSI OS Image"
	default		= "ibm-redhat-8-4-minimal-amd64-1"
}

variable "VOL1" {
	type		= string
	description = "Volume 1 Size"
	default		= "100"
}
