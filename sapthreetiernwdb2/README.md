# Automation script for distributed SAP Netweaver and DB2 installation using Terraform and Ansible integration.


## Description
This solution will perform automated deployment of a distributed system (two nodes) with **SAP Netweaver** with **DB2** on top of **Red Hat Enterprise Linux 7.6 for SAP Applications**.

It contains:  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules and two VSIs: one for the DB2 instance and one for ASCS and PAS instances.
- Ansible scripts to configure SAP Netweaver PAS, ASCS and DB2 installations.
Please note that Ansible is started by Terraform and must be available on the same host.

## Installation media
SAP installation media used for this deployment is the default one for **SAP Netweaver 7.5** with **DB2 10.5FP7** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

## IBM Cloud API Key
Your IBM Cloud API Key will be asked interactively during terraform plan step.

## VSI Configuration
The VSIs are configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64) and have two SSH keys configured to access as root user on SSH. 

## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys like so:
```shell
#Infra VPC variables
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "sapnwdb2"
DB-PROFILE		= "bx2-4x16"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-1" # For any manual change in the terraform code, you have to make sure that you use a certified image based on the SAP NOTE: 2927211.

# SAP APPs VSI variables:
APP-HOSTNAME	= "sapnwapp"
APP-PROFILE		= "bx2-4x16"
APP-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-1" # For any manual change in the terraform code, you have to make sure that you use a certified image based on the SAP NOTE: 2927211.
```

Parameter | Description
----------|------------
REGION | The cloud region where to deploy the solution. The regions and zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc)
ZONE | The cloud zone where to deploy the solution
VPC | The name of the VPC. The list of VPCs is available [here](https://cloud.ibm.com/vpc-ext/network/vpcs)
SECURITYGROUP | The name of the Security Group. The list of Security Groups is available [here](https://cloud.ibm.com/vpc-ext/network/securityGroups)
SUBNET | The name of the Subnet. The list of Subnets is available [here](https://cloud.ibm.com/vpc-ext/network/subnets)
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs.<br> The list of SSH Keys is available [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys)
[DB/APP]-HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters as required by SAP.<br> For more information on rules regarding hostnames for SAP systems, check [SAP Note 611361: Hostnames of SAP ABAP Platform servers](https://launchpad.support.sap.com/#/notes/%20611361)
[DB/APP]-PROFILE | The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles).<br> For more information about supported DB/OS and IBM Gen 2 Virtual Server Instances (VSI), check [SAP Note 2927211: SAP Applications on IBM Virtual Private Cloud](https://launchpad.support.sap.com/#/notes/2927211)
[DB/APP]-IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images)

Edit your SAP system configuration variables that will be passed to the ansible automated deployment:

```shell
#SAP system configuration
sap_sid = "NWA"
sap_ascs_instance_number = "01"
sap_ci_instance_number = "00"

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
**SAP input parameters:**

Parameter | Description | Requirements
----------|-------------|-------------
sap_sid | The SAP system ID <SAPSID> identifies the entire SAP system | <ul><li>Consists of exactly three alphanumeric characters</li><li>Has a letter for the first character</li><li>Does not include any of the reserved IDs listed in SAP Note 1979280</li></ul>| 
sap_ci_instance_number | Technical identifier for internal processes of CI| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
sap_ascs_instance_number | Technical identifier for internal processes of ASCS| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
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

**SAP Master Password**
The password for the SAP system will be asked interactively during terraform plan step and will not be available after the deployment.

### VPC Configuration

The scripts create a new VPC with Subnet, Security Group and Security rules.
If you want to use an existing VPC with Subnet, Security Group and Security rules use the `sapthreetiernwdb2/terraform/main.tf` file as below and add the names to `input.auto.tfvars`

```shell
module "vpc" {
# source		= "./modules/vpc"   		# Uncomment only this line for creating a NEW VPC #
  source		= "./modules/vpc/existing"	# Uncomment only this line to use an EXISTING VPC #

 ```

The Security Rules are the following:
- Allow all traffic in the Security group
- Allow all outbound traffic
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)


## Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `integration.tf` - contains the integration code that brings the SAP variabiles from Terraform to Ansible.
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`.
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.




## Steps to reproduce:

For initializing terraform:

```shell
terraform init
```

For planning phase:

```shell
terraform plan --out plan1
```

For apply phase:

```shell
terraform apply "plan1"
```

For destroy:

```shell
terraform destroy
```


### Related links:

- [SAP NetWeaver design considerations](https://cloud.ibm.com/docs/sap?topic=sap-netweaver-design-considerations)
