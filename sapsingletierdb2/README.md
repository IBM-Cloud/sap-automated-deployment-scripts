# IBM Sample for VPC and VSI automatic deployment with **DB2 SAP certified storage and network configuration** using terraform and ansible integration.

This is a minimal terraform script for deploying a VPC and a VSI with SAP certified storage and network configuration.
The VPC contains one subnet and one security group having three rules:
- Allow all outbound traffic from the VSI
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)

For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.

The VSI is configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64), has two SSH keys configured to access as root user on SSH and five storage volumes as described below in 
the file `input.auto.tfvars`

-  edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and starting with minimal recommended disk sizes in `input.auto.tfvars` like so:
```shell
#Infra VPC variables
ZONE			= "eu-de-2"
VPC			= "sap"
SECURITYGROUP	= "sap-securitygroup"
SUBNET			= "sap-subnet"
HOSTNAME		= "db2saps1"
PROFILE			= "bx2-4x16"
IMAGE			= "ibm-redhat-7-6-amd64-sap-applications-1"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1			= "32"
VOL2			= "32"
VOL3			= "64"
VOL4			= "128"
VOL5			= "256"
```

-  edit your SAP system configuration variabiles that will be passed to the ansible automated deployment:

```shell
##SAP system configuration
sap_sid	= "id1"
sap_ci_instance_number = "00"
sap_ascs_instance_number = "01"
sap_master_password = "Password#1"

#Kits paths
kit_sapcar_file = "/storage/NW75DB2/SAPCAR_1010-70006178.EXE"
kit_swpm_file =  "/storage/NW75DB2/SWPM10SP31_7-20009701.SAR"
kit_saphotagent_file = "/storage/NW75DB2/SAPHOSTAGENT51_51-20009394.SAR"
kit_sapexe_file = "/storage/NW75DB2/SAPEXE_800-80002573.SAR"
kit_sapexedb_file = "/storage/NW75DB2/SAPEXEDB_800-80002603.SAR"
kit_igsexe_file = "/storage/NW75DB2/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75DB2/igshelper_17-10010245.sar"
kit_export_dir = "/storage/NW75DB2/51050829"
kit_db2_dir = "/storage/NW75DB2/51051007/DB2_FOR_LUW_10.5_FP7SAP2_LINUX_"
kit_db2client_dir = "/storage/NW75DB2/51051049"

```


- edit the files sapsingletierdb2/terraform/main.tf in order to choose if you want to create a new VPC or to use an existing one.

Example of the code on how to do it if you want to use and existing VPC and the VPC module is commented out:

vi sapsingletierdb2/terraform/main.tf

```shell
/*module "vpc" {
  source		= "./modules/vpc"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP = var.SECURITYGROUP
  SUBNET		= var.SUBNET
}
*/
```


Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.
 - `integration.tf` - contains the integration code that brings the SAP variabiles from Terraform to Ansible.



Steps to reproduce:

```shell
terraform init
```

For planning phase:

```shell
terraform plan
```

For apply phase:

```shell
terraform apply
```

For destroy:

```shell
terraform destroy
```
