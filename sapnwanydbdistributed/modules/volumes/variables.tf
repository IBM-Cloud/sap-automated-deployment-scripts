variable "ZONE" {
    type = string
    description = "Cloud Zone"
}

variable "HOSTNAME" {
    type = string
    description = "VSI DB Hostname"
}

variable "HOSTNAME-APP" {
    type = string
    description = "VSI APP Hostname"
}

variable "SWAP-DB" {
    type = string
    description = "SWAP Size"
}

variable "VOL1-DB" {
    type = string
    description = "Volume 1 Size"
}

variable "SWAP-APP" {
    type = string
    description = "SWAP Size"
}

variable "VOL1-APP" {
    type = string
    description = "Volume 1 Size"
}
