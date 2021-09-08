data "ibm_is_vpc" "vpc" {
  name		= var.VPC
}

data "ibm_is_security_group" "securitygroup" {
  name		= var.SECURITYGROUP
}

data "ibm_is_subnet" "subnet" {
  name		= var.SUBNET
}

data "ibm_is_image" "image" {
  name		= var.IMAGE
}

resource "ibm_is_instance" "vsi" {
  vpc		= data.ibm_is_vpc.vpc.id
  zone		= var.ZONE
  keys		= var.SSH_KEYS
  name		= var.HOSTNAME
  profile	= var.PROFILE
  image		= data.ibm_is_image.image.id

  primary_network_interface {
    subnet          = data.ibm_is_subnet.subnet.id
    security_groups = [ data.ibm_is_security_group.securitygroup.id ]
  }
  volumes = var.VOLUMES_LIST
}

resource "ibm_is_floating_ip" "fip" {
  name		= "${var.HOSTNAME}-fip"
  target	= ibm_is_instance.vsi.primary_network_interface[0].id
}
