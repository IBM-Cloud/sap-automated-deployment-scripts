data "ibm_is_vpc" "vpc" {
  name		= var.VPC
}

resource "ibm_is_subnet" "subnet" {
  zone                     = var.ZONE
  name                     = var.SUBNET
  vpc		= data.ibm_is_vpc.vpc.id
  total_ipv4_address_count = 32
}

resource "ibm_is_security_group" "securitygroup" {
  name		= var.SECURITYGROUP
  vpc		= data.ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group_rule" "outbound_all" {
  group		= ibm_is_security_group.securitygroup.id
  direction	= "outbound"
  remote	= "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "inbound_dns_all" {
  group		= ibm_is_security_group.securitygroup.id
  direction	= "inbound"
  remote	= "0.0.0.0/0"

  udp {
    port_min	= 53
    port_max	= 53
  }
}

resource "ibm_is_security_group_rule" "inbound_ssh_all" {
  group		= ibm_is_security_group.securitygroup.id
  direction	= "inbound"
  remote	= "0.0.0.0/0"

  tcp {
    port_min	= 22
    port_max	= 22
  }
}

resource "ibm_is_security_group_rule" "inbound_sg_all" {
  group		= ibm_is_security_group.securitygroup.id
  direction	= "inbound"
  remote	= ibm_is_security_group.securitygroup.id
}

resource "ibm_is_security_group_rule" "fip_inbound_bastion_access" {
  count = (var.ADD_OPEN_PORTS_IN_NEW_SUBNET == "yes" ? 1: 0)
  group		= ibm_is_security_group.securitygroup.id
  direction	= "inbound"
  remote	= "0.0.0.0/0"

  tcp {
    port_min	= var.OPEN_PORT_MINIMUM
    port_max	= var.OPEN_PORT_MAXIMUM
  }
}
