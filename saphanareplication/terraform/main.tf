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

module "dbstandby-vsi" {
  source		= "./modules/dbstandby-vsi"
  depends_on	= [ module.vpc ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.DBSTANDBY-HOSTNAME
  PROFILE		= var.DB-PROFILE
  IMAGE			= var.DB-IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUME_SIZES	= [ "500" , "500" , "500" ]
  VOL_PROFILE	= "custom"
  VOL_IOPS		= "10000"
}

module "db-ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.db-vsi , module.dbstandby-vsi, local_file.db_ansible_saphanadb-vars ]
  IP			= module.db-vsi.PRIVATE-IP
  PLAYBOOK_PATH = "../ansible/saphanadb.yml"
}

module "dbstandby-ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.db-ansible-exec , module.dbstandby-vsi , local_file.db_ansible_saphanastanby-vars ]
  IP			= module.dbstandby-vsi.PRIVATE-IP
  PLAYBOOK_PATH = "../ansible/saphanadbstandby.yml"
}

module "sec-exec" {
  source		= "./modules/sec-exec"
  depends_on	= [ module.dbstandby-ansible-exec ]
  IP			= module.db-vsi.PRIVATE-IP
  sap_master_password = var.sap_master_password
}
