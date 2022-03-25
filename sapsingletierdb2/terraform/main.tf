module "vpc-subnet" {
  source		= "./modules/vpc/subnet"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  ADD_OPEN_PORTS = var.ADD_OPEN_PORTS
  OPEN_PORT_MINIMUM = var.OPEN_PORT_MINIMUM
  OPEN_PORT_MAXIMUM = var.OPEN_PORT_MAXIMUM
  SUBNET		= var.SUBNET
  count = (var.ADD_OPEN_PORTS == "yes" ? 1: 0)
}


module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  VOL1			= var.VOL1
  VOL2			= var.VOL2
  VOL3			= var.VOL3
  VOL4			= var.VOL4
  VOL5			= var.VOL5
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
  SAP_SID		= var.sap_sid
}


module "ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.vsi ]
  IP			= module.vsi.PRIVATE-IP
  sap_master_password = var.sap_master_password
}
