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

variable "SSH_KEYS" {
	type		= list(string)
	description = "SSH Keys ID list to access the VSI"
}

variable "DB-HOSTNAME" {
	type		= string
	description = "DB VSI Hostname"
}

variable "DB-PROFILE" {
	type		= string
	description = "DB VSI Profile"
	default		= "mx2-16x128"
}

variable "DB-IMAGE" {
	type		= string
	description = "DB VSI OS Image"
	default		= "ibm-redhat-7-6-amd64-sap-hana-1"
}

variable "APP-HOSTNAME" {
	type		= string
	description = "APP VSI Hostname"
}

variable "APP-PROFILE" {
	type		= string
	description = "VSI Profile"
	default		= "bx2-4x16"
}

variable "APP-IMAGE" {
	type		= string
	description = "VSI OS Image"
	default		= "ibm-redhat-7-6-amd64-sap-applications-1"
}

variable "hana_sid" {
	type		= string
	description = "hana_sid"
	default		= "HDB"
}

variable "hana_sysno" {
	type		= string
	description = "hana_sysno"
	default		= "00"
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
	default		= "51054623.ZIP"
}

variable "sap_sid" {
	type		= string
	description = "sap_sid"
	default		= "S4A"
}

variable "sap_ascs_instance_number" {
	type		= string
	description = "sap_ascs_instance_number"
	default		= "01"
}

variable "sap_ci_instance_number" {
	type		= string
	description = "sap_ci_instance_number"
	default		= "00"
}

variable "sap_master_password" {
	type		= string
	description = "sap_master_password"
}

variable "hdb_concurrent_jobs" {
	type		= string
	description = "hdb_concurrent_jobs"
	default		= "23"
}

variable "kit_sapcar_file" {
	type		= string
	description = "kit_sapcar_file"
	default		= "SAPCAR_1010-70006178.EXE"
}

variable "kit_swpm_file" {
	type		= string
	description = "kit_swpm_file"
	default		= "SWPM20SP09_4-80003424.SAR"
}

variable "kit_sapexe_file" {
	type		= string
	description = "kit_sapexe_file"
	default		= "SAPEXE_100-70005283.SAR"
}

variable "kit_sapexedb_file" {
	type		= string
	description = "kit_sapexedb_file"
	default		= "SAPEXEDB_100-70005282.SAR"
}

variable "kit_igsexe_file" {
	type		= string
	description = "kit_igsexe_file"
	default		= "igsexe_1-70005417.sar"
}

variable "kit_igshelper_file" {
	type		= string
	description = "kit_igshelper_file"
	default		= "igshelper_17-10010245.sar"
}

variable "kit_saphotagent_file" {
	type		= string
	description = "kit_saphotagent_file"
	default		= "SAPHOSTAGENT51_51-20009394.SAR"
}

variable "kit_hdbclient_file" {
	type		= string
	description = "kit_hdbclient_file"
	default		= "IMDB_CLIENT20_009_28-80002082.SAR"
}

variable "kit_s4hana_export" {
	type		= string
	description = "kit_s4hana_export"
	default		= "/S4HANA/export"
}

