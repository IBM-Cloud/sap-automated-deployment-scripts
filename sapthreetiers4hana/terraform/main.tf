module "vpc" {
# source		= "./modules/vpc"   		# Uncomment only this line for creating a NEW VPC #
  source		= "./modules/vpc/existing"	# Uncomment only this line to use an EXISTING VPC #

  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}

module "db-vsi" {
  source		= "./modules/db-vsi"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.DB-HOSTNAME
  PROFILE		= var.DB-PROFILE
  IMAGE			= var.DB-IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= [ "500" , "500" , "500" ]
  VOL_PROFILE	= "custom"
  VOL_IOPS		= "10000"
}

module "app-vsi" {
  source		= "./modules/app-vsi"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.APP-HOSTNAME
  PROFILE		= var.APP-PROFILE
  IMAGE			= var.APP-IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= [ "40" , "128" ]
  VOL_PROFILE	= "10iops-tier"
}

module "db-ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.app-vsi ]
  IP			= module.app-vsi.PRIVATE-IP
  PLAYBOOK_PATH = "../ansible/saphanasinglehost.yml"
}