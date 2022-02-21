module "vpc" {
  source		= "./modules/vpc"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  count = (var.VPC_EXISTS == "no" && var.SUBNET_EXISTS == "no" ? 1: 0)
}

module "vpc-subnet" {
  source		= "./modules/vpc/subnet"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  ADD_OPEN_PORTS_IN_NEW_SUBNET = var.ADD_OPEN_PORTS_IN_NEW_SUBNET
  OPEN_PORT_MINIMUM = var.OPEN_PORT_MINIMUM
  OPEN_PORT_MAXIMUM = var.OPEN_PORT_MAXIMUM
  SUBNET		= var.SUBNET
  count = (var.SUBNET_EXISTS == "no" ? 1: 0)
}

module "volumes" {
  source		= "./modules/volumes"
  depends_on	= [ module.vpc-subnet ]
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  SUBNET		= var.SUBNET
  VOL_PROFILE	= "custom"
  VOL_IOPS		= "3000"
  VOL1			= var.VOL1
}


module "vsi" {
  source		= "./modules/vsi"
  depends_on	= [ module.volumes ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.HOSTNAME
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUMES_LIST	= module.volumes.volumes_list
}

module "install-prereq" {
  source		= "./modules/install-prereq"
  depends_on	= [ module.vsi ]
#  IP			= module.vsi.PRIVATE-IP
   IP			= module.vsi.FLOATING-IP
  private_ssh_key = var.private_ssh_key
}
