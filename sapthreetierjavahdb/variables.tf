variable "REGION" {
	type		= string
	description	= "Cloud Region"
	validation {
		condition     = contains(["au-syd", "jp-osa", "jp-tok", "eu-de", "eu-gb", "ca-tor", "us-south", "us-east", "br-sao"], var.REGION ) 
		error_message = "The REGION must be one of: au-syd, jp-osa, jp-tok, eu-de, eu-gb, ca-tor, us-south, us-east, br-sao."
	}
}

variable "ZONE" {
	type		= string
	description	= "Cloud Zone"
	validation {
		condition     = length(regexall("^(au-syd|jp-osa|jp-tok|eu-de|eu-gb|ca-tor|us-south|us-east|br-sao)-(1|2|3)$", var.ZONE)) > 0
		error_message = "The ZONE is not valid."
	}
}

variable "VPC" {
	type		= string
	description = "VPC name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.VPC)) > 0
		error_message = "The VPC name is not valid."
	}
}

variable "SUBNET" {
	type		= string
	description = "Subnet name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SUBNET)) > 0
		error_message = "The SUBNET name is not valid."
	}
}

variable "SECURITYGROUP" {
	type		= string
	description = "Security group name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SECURITYGROUP)) > 0
		error_message = "The SECURITYGROUP name is not valid."
	}
}

variable "SSH_KEYS" {
	type		= list(string)
	description = "SSH Keys ID list to access the VSI"
	validation {
		condition     = var.SSH_KEYS == [] ? false : true && var.SSH_KEYS == [""] ? false : true
		error_message = "At least one SSH KEY is needed to be able to access the VSI."
	}
}

variable "DB-HOSTNAME" {
	type		= string
	description = "DB VSI Hostname"
	validation {
		condition     = length(var.DB-HOSTNAME) <= 13 && length(regexall("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.DB-HOSTNAME)) > 0
		error_message = "The DB-HOSTNAME is not valid."
	}
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
	validation {
		condition     = length(var.APP-HOSTNAME) <= 13 && length(regexall("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.APP-HOSTNAME)) > 0
		error_message = "The APP-HOSTNAME is not valid."
	}
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
	validation {
		condition     = length(regexall("^[a-zA-Z][a-zA-Z0-9][a-zA-Z0-9]$", var.hana_sid)) > 0
		error_message = "The hana_sid is not valid."
	}
}

variable "hana_sysno" {
	type		= string
	description = "hana_sysno"
	default		= "00"
	validation {
		condition     = var.hana_sysno >= 0 && var.hana_sysno <=97
		error_message = "The hana_sysno is not valid."
	}
}

variable "hana_system_usage" {
	type		= string
	description = "hana_system_usage"
	default		= "custom"
	validation {
		condition     = contains(["production", "test", "development", "custom" ], var.hana_system_usage ) 
		error_message = "The hana_system_usage must be one of: production, test, development, custom."
	}
}

variable "hana_components" {
	type		= string
	description = "hana_components"
	default		= "server"
	validation {
		condition     = contains(["all", "client", "es", "ets", "lcapps", "server", "smartda", "streaming", "rdsync", "xs", "studio", "afl", "sca", "sop", "eml", "rme", "rtl", "trp" ], var.hana_components ) 
		error_message = "The hana_components must be one of: all, client, es, ets, lcapps, server, smartda, streaming, rdsync, xs, studio, afl, sca, sop, eml, rme, rtl, trp."
	}
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
	validation {
		condition     = length(regexall("^[a-zA-Z][a-zA-Z0-9][a-zA-Z0-9]$", var.sap_sid)) > 0
		error_message = "The sap_sid is not valid."
	}
}

variable "sap_scs_instance_number" {
	type		= string
	description = "sap_scs_instance_number"
	default		= "01"
	validation {
		condition     = var.sap_scs_instance_number >= 0 && var.sap_scs_instance_number <=97
		error_message = "The sap_scs_instance_number is not valid."
	}
}

variable "sap_ci_instance_number" {
	type		= string
	description = "sap_ci_instance_number"
	default		= "00"
	validation {
		condition     = var.sap_ci_instance_number >= 0 && var.sap_ci_instance_number <=97
		error_message = "The sap_ci_instance_number is not valid."
	}
}

variable "sap_master_password" {
	type		= string
	sensitive = true
	description = "sap_master_password"
	validation {
		condition     = length(regexall("^(.{0,9}|.{15,}|[^0-9]*)$", var.sap_master_password)) == 0 && length(regexall("^[^0-9_][0-9a-zA-Z@#$_]+$", var.sap_master_password)) > 0
		error_message = "The sap_master_password is not valid."
	}
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
	default		= "SAPEXE_400-80004393.SAR"
}

variable "kit_sapexedb_file" {
	type		= string
	description = "kit_sapexedb_file"
	default		= "SAPEXEDB_400-80004392.SAR"
}

variable "kit_igsexe_file" {
	type		= string
	description = "kit_igsexe_file"
	default		= "igsexe_13-80003187.sar"
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

variable "kit_sapjvm_file" {
	type		= string
	description = "kit_sapjvm_file"
	default		= "SAPJVM8_73-80000202.SAR"
}

variable "kit_java_export" {
	type		= string
	description = "kit_java_export"
	default		= "/JAVA/export"
}

