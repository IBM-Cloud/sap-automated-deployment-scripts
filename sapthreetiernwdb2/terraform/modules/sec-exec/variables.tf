variable "IP" {
    type = string
    description = "IP used to execute ansible"
}

variable "sap_master_password" {
	type		= string
	sensitive = true
	description = "sap_master_password"
}
