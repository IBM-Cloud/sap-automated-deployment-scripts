# Automation script for central SAP Netweaver and DB2 installation using Terraform and Ansible integration.


## Description
This solution will perform automated deployment of a single host with **SAP Netweaver** with **DB2** on top of **Red Hat Enterprise Linux 7.6 for SAP Applications**.

It contains:  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules and a VSI.
- Ansible scripts to configure SAP Netweaver and DB2 installation.
Please note that Ansible is started by Terraform and must be available on the same host.

## Installation media
SAP installation media used for this deployment is the default one for **SAP Netweaver 7.5** with **DB2 10.5FP7** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

## IBM Cloud API Key
For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.

## VSI Configuration
The VSI is configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64), has two SSH keys configured to access as root user on SSH and five storage volumes as described below in 
the file `input.auto.tfvars`

## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and starting with minimal recommended disk sizes like so:
```shell
#Infra VPC variables
ZONE			= "eu-de-2"
VPC			= "sap"
SECURITYGROUP		= "sap-securitygroup"
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

Parameter | Description
----------|------------
ZONE | The cloud zone where to deploy the solution. Must match the Region defined in `provider.tf`. The zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc)
VPC | The name of the VPC
SECURITYGROUP | The name of the Security Group
SUBNET | The name of the Subnet
HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note *611361 - Hostnames of SAP ABAP Platform servers*
PROFILE | The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles)
IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images)
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The Keys added to IBM Cloud can be found [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys)
VOL[number] | The sizes for the disks in GB to be attached to the VSI and used by SAP

Edit your SAP system configuration variables that will be passed to the ansible automated deployment:

```shell
##SAP system configuration
sap_sid	= "NWS"
sap_ci_instance_number = "00"
sap_ascs_instance_number = "01"
sap_master_password = "Password#1"

#Kits paths
kit_sapcar_file = "/storage/NW75DB2/SAPCAR_1010-70006178.EXE"
kit_swpm_file =  "/storage/NW75DB2/SWPM10SP31_7-20009701.SAR"
kit_saphostagent_file = "/storage/NW75DB2/SAPHOSTAGENT51_51-20009394.SAR"
kit_sapexe_file = "/storage/NW75DB2/SAPEXE_800-80002573.SAR"
kit_sapexedb_file = "/storage/NW75DB2/SAPEXEDB_800-80002603.SAR"
kit_igsexe_file = "/storage/NW75DB2/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75DB2/igshelper_17-10010245.sar"
kit_export_dir = "/storage/NW75DB2/51050829"
kit_db2_dir = "/storage/NW75DB2/51051007/DB2_FOR_LUW_10.5_FP7SAP2_LINUX_"
kit_db2client_dir = "/storage/NW75DB2/51051049"

```
**SAP input parameters:**

Parameter | Description | Requirements
----------|-------------|-------------
sap_sid | The SAP system ID <SAPSID> identifies the entire SAP system | <ul><li>Consists of exactly three alphanumeric characters</li><li>Has a letter for the first character</li><li>Does not include any of the reserved IDs listed in SAP Note 1979280</li></ul>| 
sap_ci_instance_number | Technical identifier for internal processes of CI| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
sap_ascs_instance_number | Technical identifier for internal processes of ASCS| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
sap_master_password | Common password for all users that are created during the installation | <ul><li>It must be 8 to 14 characters long</li><li>It must contain at least one digit (0-9)</li><li>It must not contain \ (backslash) and " (double quote)</li></ul>
kit_sapcar_file  | Path to sapcar binary | As downloaded from SAP Support Portal
kit_swpm_file | Path to SWPM archive (SAR) | As downloaded from SAP Support Portal
kit_saphostagent_file | Path to SAP Host Agent archive (SAR) | As downloaded from SAP Support Portal
kit_sapexe_file | Path to SAP Kernel OS archive (SAR) | As downloaded from SAP Support Portal
kit_sapexedb_file | Path to SAP Kernel DB archive (SAR) | As downloaded from SAP Support Portal
kit_igsexe_file | Path to IGS archive (SAR) | As downloaded from SAP Support Portal
kit_igshelper_file | Path to IGS Helper archive (SAR) | As downloaded from SAP Support Portal
kit_export_dir | Path to NW 7.5 Installation Export dir | The archive downloaded from SAP Support Portal must be extracted and the path provided to this parameter must contain LABEL.ASC file
kit_db2_dir | Path to DB2 LUW 10.5 FP7SAP2 Linux on x86_64 64bit dir | The archive downloaded from SAP Support Portal must be extracted and the path provided to this parameter must contain LABEL.ASC file
kit_db2client_dir | Path to DB2 LUW 10.5 FP7SAP2 RDBMS Client dir | The archive downloaded from SAP Support Portal must be extracted and the path provided to this parameter must contain LABEL.ASC file


## VPC Configuration

The scripts create a new VPC with Subnet, Security Group and Security rules.
If you want to use an existing VPC with Subnet, Security Group and Security rules use the `sapsingletierdb2/terraform/main.tf` file as below and add the names to `input.auto.tfvars`

```shell
/*module "vpc" {
  source		= "./modules/vpc"
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP 	= var.SECURITYGROUP
  SUBNET		= var.SUBNET
}
*/

module "volumes" {
  source		= "./modules/volumes"
  ZONE			= var.ZONE
  HOSTNAME		= var.HOSTNAME
  VOL1			= var.VOL1
  VOL2			= var.VOL2
  VOL3			= var.VOL3
  VOL4			= var.VOL4
  VOL5			= var.VOL5
}


module "vsi" {
  source		= "./modules/vsi"
#  depends_on		= [ module.vpc , module.volumes ]
  depends_on		= [ module.volumes ]
  ZONE			= var.ZONE
  VPC			= var.VPC
  SECURITYGROUP 	= var.SECURITYGROUP
  SUBNET		= var.SUBNET
  HOSTNAME		= var.HOSTNAME
  PROFILE		= var.PROFILE
  IMAGE			= var.IMAGE
  SSH_KEYS		= var.SSH_KEYS
  VOLUMES_LIST		= module.volumes.volumes_list
  SAP_SID		= var.sap_sid
}

```

The Security Rules are the following:
- Allow all outbound traffic from the VSI
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)



## Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `integration.tf` - contains the integration code that brings the SAP variabiles from Terraform to Ansible.
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.




## Steps to reproduce:

For initializing terraform:

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


### Related links:

- [See full IBM Cloud Docs, single-tier virtual private cloud for SAP](https://cloud.ibm.com/docs/sap?topic=sap-create-terraform-single-tier-vpc-sap)
