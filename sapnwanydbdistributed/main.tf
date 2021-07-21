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
  HOSTNAME-DB		= var.HOSTNAME-DB
  HOSTNAME-APP		= var.HOSTNAME-APP
  SWAP-DB			= var.SWAP-DB
  VOL1-DB		= var.VOL1-DB
  VOL2-DB		= var.VOL2-DB
  VOL3-DB		= var.VOL3-DB
  SWAP-APP			= var.SWAP-APP
  VOL1-APP		= var.VOL1-APP
}

module "vsi-db" {
  source		= "./modules/vsi/db"
#  depends_on	= [ module.vpc , module.volumes ]
  depends_on	= [ module.volumes ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME-DB		= var.HOSTNAME-DB
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUMES_LIST_DB	= module.volumes.volumes_list_db
}


module "vsi-app" {
  source		= "./modules/vsi/app"
#  depends_on	= [ module.vpc , module.volumes ]
  depends_on	= [ module.volumes ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME-APP		= var.HOSTNAME-APP
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUMES_LIST_APP	= module.volumes.volumes_list_app
}
