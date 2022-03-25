data "ibm_is_vpc" "vpc" {
  name		= var.VPC
}

data "ibm_is_subnet" "subnet" {
  name		= var.SUBNET
}

data "ibm_is_security_group" "securitygroup" {
  name		= var.SECURITYGROUP
}

resource "ibm_is_security_group_rule" "fip_inbound_SAP_GUI_access" {
  count = (var.ADD_OPEN_PORTS == "yes" ? 1: 0)
  group		= data.ibm_is_security_group.securitygroup.id
  direction	= "inbound"
  remote	= "0.0.0.0/0"

  tcp {
    port_min	= var.OPEN_PORT_MINIMUM
    port_max	= var.OPEN_PORT_MAXIMUM
  }
}
