module "vpc" {
 source		= "./modules/vpc/existing" # Uncomment out only this line to use an Existing IBM VPC #
#  source		= "./modules/vpc"   # Uncomment out only this line  for creating a NEW IBM VPC #

  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}

module "db-vsi" {
  source		= "./modules/vsi"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.DB-HOSTNAME
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= var.DB-VOLUME_SIZES
}

module "app-vsi" {
  source		= "./modules/vsi"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.APP-HOSTNAME
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= var.APP-VOLUME_SIZES
}
