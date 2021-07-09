module "vpc" {
  source		= "./modules/vpc"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}

module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  VOL1			= var.VOL1
}

module "vsi" {
  source		= "./modules/vsi"
  depends_on	= [ module.vpc , module.volumes ]
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