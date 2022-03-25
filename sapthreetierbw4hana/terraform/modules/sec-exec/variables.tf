variable "IP" {
    type = string
    description = "IP used to execute ansible"
}

variable "sap_master_password" {
	type		= string
	sensitive = true
	description = "sap_master_password"
}

variable "hana_master_password" {
	type		= string
	sensitive = true
	description = "hana_master_password"
}
