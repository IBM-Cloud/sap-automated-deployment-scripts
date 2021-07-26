variable "REGION" {
	type		= string
	description	= "Cloud Region"
}

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

variable "DB-HOSTNAME" {
	type		= string
	description = "DB VSI Hostname"
}

variable "DB-VOLUME_SIZES" {
	type		= list(string)
	description = "DB list of volume sizes in GB to be created"
}

variable "APP-HOSTNAME" {
	type		= string
	description = "APP VSI Hostname"
}

variable "APP-VOLUME_SIZES" {
	type		= list(string)
	description = "APP list of volume sizes in GB to be created"
}
