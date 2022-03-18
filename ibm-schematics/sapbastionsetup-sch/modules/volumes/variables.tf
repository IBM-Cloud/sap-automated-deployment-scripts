variable "ZONE" {
    type = string
    description = "Cloud Zone"
}

variable "HOSTNAME" {
    type = string
    description = "VSI Hostname"
}

variable "SUBNET" {
    type = string
    description = "Subnet name"
}

variable "VOL_PROFILE" {
	type		= string
	description = "Volume Profile"
	default		= "custom"
}


variable "VOL_IOPS" {
	type		= string
	description = "Volume IOPS"
	default		= "3000"
}


variable "VOL1" {
	type		= string
	description = "Volume 1 Size"
	default		= "100"
}
