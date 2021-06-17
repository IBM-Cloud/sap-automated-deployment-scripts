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

variable "VOL1" {
	type		= string
	description = "Volume 1 Size"
	default		= "10"
}

variable "VOL2" {
	type		= string
	description = "Volume 2 Size"
	default		= "10"
}

variable "VOL3" {
	type		= string
	description = "Volume 3 Size"
	default		= "10"
}

variable "VOL4" {
	type		= string
	description = "Volume 4 Size"
	default		= "10"
}

variable "VOL5" {
	type		= string
	description = "Volume 5 Size"
	default		= "10"
}

variable "SAP_SID" {
	type		= string
	description = "SAP SID"
}
