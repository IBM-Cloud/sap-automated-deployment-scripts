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

variable "sap_sid" {
	type		= string
	description = "sap_sid"
}

variable "sap_ci_instance_number" {
	type		= string
	description = "sap_ci_instance_number"
}

variable "sap_ascs_instance_number" {
	type		= string
	description = "sap_ascs_instance_number"
}

variable "sap_master_password" {
	type		= string
	description = "sap_master_password"
}

variable "kit_sapcar_file" {
	type		= string
	description = "kit_sapcar_file"
}

variable "kit_swpm_file" {
	type		= string
	description = "kit_swpm_file"
}

variable "kit_saphotagent_file" {
	type		= string
	description = "kit_saphotagent_file"
}

variable "kit_sapexe_file" {
	type		= string
	description = "kit_sapexe_file"
}

variable "kit_sapexedb_file" {
	type		= string
	description = "kit_sapexedb_file"
}

variable "kit_igsexe_file" {
	type		= string
	description = "kit_igsexe_file"
}

variable "kit_igshelper_file" {
	type		= string
	description = "kit_igshelper_file"
}

variable "kit_export_dir" {
	type		= string
	description = "kit_export_dir"
}

variable "kit_db2_dir" {
	type		= string
	description = "kit_db2_dir"
}

variable "kit_db2client_dir" {
	type		= string
	description = "kit_db2client_dir"
}
