variable "ZONE" {
    type = string
    description = "Cloud Zone"
}

variable "HOSTNAME-DB" {
    type = string
    description = "VSI DB Hostname"
}

variable "HOSTNAME-APP" {
    type = string
    description = "VSI APP Hostname"
}

variable "SWAP-DB" {
    type = string
    description = "SWAP DB Size"
}

variable "VOL1-DB" {
    type = string
    description = "Volume 1 DB Size"
}


variable "VOL2-DB" {
    type = string
    description = "Volume 2 DB Size"
}


variable "VOL3-DB" {
    type = string
    description = "Volume 3 DB Size"
}

variable "SWAP-APP" {
    type = string
    description = "SWAP APP Size"
}

variable "VOL1-APP" {
    type = string
    description = "Volume 1 APP Size"
}
