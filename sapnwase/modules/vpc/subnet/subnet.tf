data "ibm_is_vpc" "vpc" {
  name		= var.VPC
}

data "ibm_is_subnet" "subnet" {
  name		= var.SUBNET
}

# data "ibm_resource_group" "group" {
#   name		= var.RESOURCE_GROUP
# }

data "ibm_is_security_group" "securitygroup" {
  name		= var.SECURITY_GROUP
}
