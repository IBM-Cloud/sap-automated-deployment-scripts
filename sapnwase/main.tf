module "vpc-subnet" {
  source		= "./modules/vpc/subnet"
  ZONE			= var.ZONE
  # RESOURCE_GROUP = var.RESOURCE_GROUP
  VPC			= var.VPC
  SECURITY_GROUP = var.SECURITY_GROUP
  SUBNET		= var.SUBNET
}


module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  RESOURCE_GROUP = var.RESOURCE_GROUP
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
  SECURITY_GROUP = var.SECURITY_GROUP
  SUBNET		= var.SUBNET
  RESOURCE_GROUP = var.RESOURCE_GROUP
  HOSTNAME		= var.HOSTNAME
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUMES_LIST	= module.volumes.volumes_list
  SAP_SID		= var.sap_sid
}


module "ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.vsi, local_file.tf_ansible_vars_generated_file ]
  IP			= module.vsi.PRIVATE-IP
  sap_main_password = var.sap_main_password
}
