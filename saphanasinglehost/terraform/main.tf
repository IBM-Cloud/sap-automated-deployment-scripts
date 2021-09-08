module "vpc" {
# source		= "./modules/vpc"   		# Uncomment only this line for creating a NEW VPC #
  source		= "./modules/vpc/existing"	# Uncomment only this line to use an EXISTING VPC #

  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}

module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  VOL_PROFILE	= "custom"
  VOL_IOPS		= "10000"
  VOL1			= var.VOL1
  VOL2			= var.VOL2
  VOL3			= var.VOL3
}


module "vsi" {
  source		= "./modules/vsi"
#  depends_on	= [ module.vpc , module.volumes ]
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

module "ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.vsi ]
  IP			= module.vsi.PRIVATE-IP
}