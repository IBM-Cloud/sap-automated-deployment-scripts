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

variable "hana_sid" {
	type		= string
	description = "hana_sid"
}

variable "hana_sysno" {
	type		= string
	description = "hana_sysno"
}

variable "hana_master_password" {
	type		= string
	description = "hana_master_password"
}

variable "hana_system_usage" {
	type		= string
	description = "hana_system_usage"
	default		= "custom"
}

variable "hana_components" {
	type		= string
	description = "hana_components"
	default		= "server"
}

variable "kit_saphana_file" {
	type		= string
	description = "kit_saphana_file"
}
