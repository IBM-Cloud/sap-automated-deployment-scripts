
module "precheck-ssh-exec" {
  source		= "./modules/precheck-ssh-exec"
  BASTION_FLOATING_IP = var.BASTION_FLOATING_IP
  private_ssh_key = var.private_ssh_key
  HOSTNAME		= var.DB-HOSTNAME
}

module "vpc-subnet" {
  depends_on	= [ module.precheck-ssh-exec ]
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

module "db-vsi" {
  depends_on	= [ module.precheck-ssh-exec ]
  source		= "./modules/db-vsi"
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
  depends_on	= [ module.db-vsi ]
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
  depends_on	= [ module.db-vsi , local_file.db_ansible_saphana-vars ]
  IP			= module.db-vsi.PRIVATE-IP
  PLAYBOOK = "saphana.yml"
  BASTION_FLOATING_IP = var.BASTION_FLOATING_IP
  private_ssh_key = var.private_ssh_key
}

module "app-ansible-exec" {
  source		= "./modules/ansible-exec"
  depends_on	= [ module.db-ansible-exec , module.app-vsi , local_file.app_ansible_saps4app-vars ]
  IP			= module.app-vsi.PRIVATE-IP
  PLAYBOOK = "saps4app.yml"
  BASTION_FLOATING_IP = var.BASTION_FLOATING_IP
  private_ssh_key = var.private_ssh_key
}
