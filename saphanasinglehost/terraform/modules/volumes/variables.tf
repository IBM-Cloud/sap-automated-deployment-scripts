variable "ZONE" {
    type = string
    description = "Cloud Zone"
}

variable "HOSTNAME" {
    type = string
    description = "VSI Hostname"
}

variable "VOL_PROFILE" {
	type		= string
	description = "Volume Profile"
	default		= "custom"
}

variable "VOL_IOPS" {
	type		= string
	description = "Volume IOPS"
	default		= "2000"
}

variable "VOL1" {
	type		= string
	description = "Volume 1 Size"
	default		= "500"
}

variable "VOL2" {
	type		= string
	description = "Volume 2 Size"
	default		= "500"
}

variable "VOL3" {
	type		= string
	description = "Volume 3 Size"
	default		= "500"
}

