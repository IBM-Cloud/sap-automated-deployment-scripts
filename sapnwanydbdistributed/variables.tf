variable "ZONE" {
	type		= string
	description	= "Cloud Zone"
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


variable "HOSTNAME-APP" {
	type		= string
	description = "VSI APP Hostname"
}


variable "PROFILE" {
	type		= string
	description = "VSI Profile"
	default		= "bx2-4x16"
}

variable "IMAGE" {
	type		= string
	description = "VSI OS Image"
	default		= "ibm-redhat-7-6-amd64-sap-applications-1"
}

variable "SSH_KEYS" {
	type		= list(string)
	description = "SSH Keys ID list to access the VSI"
}

variable "SWAP-DB" {
	type		= string
	description = "SWAP Size"
	default		= "48"
}

variable "VOL1-DB" {
	type		= string
	description = "Volume 1 Size"
	default		= "10"
}


variable "SWAP-APP" {
	type		= string
	description = "SWAP Size"
	default		= "48"
}

variable "VOL1-APP" {
	type		= string
	description = "Volume 1 Size"
	default		= "10"
}
