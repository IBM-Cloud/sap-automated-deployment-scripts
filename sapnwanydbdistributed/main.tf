/*module "vpc" {
  source		= "./modules/vpc"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}
*/

module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  HOSTNAME-APP		= var.HOSTNAME-APP
  SWAP-DB			= var.SWAP-DB
  VOL1-DB		= var.VOL1-DB
  SWAP-APP			= var.SWAP-DB
  VOL1-APP		= var.VOL1-DB
}

module "vsi" {
  source		= "./modules/vsi/db"
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
  VOLUMES_LIST_DB	= module.volumes.volumes_list_db
}
