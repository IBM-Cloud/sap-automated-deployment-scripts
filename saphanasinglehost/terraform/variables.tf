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
	description = "EXISTING VPC name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.VPC)) > 0
		error_message = "The VPC name is not valid."
	}
}

variable "SUBNET" {
	type		= string
	description = "EXISTING Subnet name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SUBNET)) > 0
		error_message = "The SUBNET name is not valid."
	}
}

variable "SECURITYGROUP" {
	type		= string
	description = "EXISTING Security group name"
	validation {
		condition     = length(regexall("^([a-z]|[a-z][-a-z0-9]*[a-z0-9]|[0-9][-a-z0-9]*([a-z]|[-a-z][-a-z0-9]*[a-z0-9]))$", var.SECURITYGROUP)) > 0
		error_message = "The SECURITYGROUP name is not valid."
	}
}


variable "ADD_OPEN_PORTS" {
	type		= string
	description = "To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options."
	default		= "no"
	validation {
		condition = var.ADD_OPEN_PORTS == "yes" || var.ADD_OPEN_PORTS =="no"
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


variable "HOSTNAME" {
	type		= string
	description = "VSI Hostname"
	validation {
		condition     = length(var.HOSTNAME) <= 13 && length(regexall("^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\\-]*[a-zA-Z0-9])\\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\\-]*[A-Za-z0-9])$", var.HOSTNAME)) > 0
		error_message = "The HOSTNAME is not valid."
	}
}


variable "PROFILE" {
	type		= string
	description = "VSI Profile"
	default		= "bx2-4x16"
}

variable "IMAGE" {
	type		= string
	description = "VSI OS Image"
	default		= "ibm-redhat-7-6-amd64-sap-hana-3"
}

variable "SSH_KEYS" {
	type		= list(string)
	description = "SSH Keys ID list to access the VSI"
	validation {
		condition     = var.SSH_KEYS == [] ? false : true && var.SSH_KEYS == [""] ? false : true
		error_message = "At least one SSH KEY is needed to be able to access the VSI."
	}
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
	sensitive = true
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
