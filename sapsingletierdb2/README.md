# Automation script for central SAP Netweaver and DB2 installation using Terraform and Ansible integration.


## Description
This solution will perform automated deployment of a single host with **SAP Netweaver** with **DB2** on top of **Red Hat Enterprise Linux 7.6 for SAP Applications**.

It contains:  
- Terraform scripts for deploying a VSI in an EXISTNG VPC with Subnet and Security Group configs.
- Ansible scripts to configure SAP Netweaver and DB2 installation.
Please note that Ansible is started by Terraform and must be available on the same host.

## Installation media
SAP installation media used for this deployment is the default one for **SAP Netweaver 7.5** with **DB2 10.5FP7** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

## IBM Cloud API Key
For the script configuration add your IBM Cloud API Key in terraform planning phase command 'terraform plan --out plan1'.
You can create an API Key [here](https://cloud.ibm.com/iam/apikeys).

## VSI Configuration
The VSI is configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64), has two SSH keys configured to access as root user on SSH and five storage volumes as described below in 
the file `input.auto.tfvars`

## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and starting with minimal recommended disk sizes like so:


**VSI input parameters**

```shell
#Infra VPC variables
REGION			 = "eu-de"
ZONE			= "eu-de-2"
VPC			= "sap"                         # EXISTING VPC name
SECURITYGROUP	= "sap-securitygroup"   # EXISTING Security group name
SUBNET			= "sap-subnet"               # EXISTING Subnet name
ADD_OPEN_PORTS = "no"                 # To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options
OPEN_PORT_MINIMUM = "3200"            # This variables will be created only if ADD_OPEN_PORTS = "yes"
OPEN_PORT_MAXIMUM = "3200"            # This variables will be created only if ADD_OPEN_PORTS = "yes"
HOSTNAME		= "db2sapm1"
PROFILE			= "bx2-4x16"
IMAGE			= "ibm-redhat-7-6-amd64-sap-applications-x"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1			= "32"
VOL2			= "32"
VOL3			= "64"
VOL4			= "128"
VOL5			= "256"
```

Parameter | Description
----------|------------
ibmcloud_api_key | IBM Cloud API key (Sensitive* value).
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The list of SSH Keys is available [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys). <br /> Sample input (use your own SSH IDS from IBM Cloud):<br /> [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
REGION | The cloud region where to deploy the solution. <br /> The regions and zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc). <br /> Sample value: eu-de.
ZONE | The cloud zone where to deploy the solution. <br /> Sample value: eu-de-2.
VPC | EXISTING VPC name. The list of VPCs is available [here](https://cloud.ibm.com/vpc-ext/network/vpcs)
SUBNET | EXISTING Subnet name. The list of Subnets is available [here](https://cloud.ibm.com/vpc-ext/network/subnets). 
SECURITYGROUP | EXISTING Security group name. The list of Security Groups is available [here](https://cloud.ibm.com/vpc-ext/network/securityGroups). 
ADD_OPEN_PORTS | To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options.
OPEN_PORT_MINIMUM | (Required, Integer) The TCP port range that includes the minimum bound. Valid values are from 1 to 65535.<br /> Default value: 3200
OPEN_PORT_MAXIMUM | (Required, Integer) The TCP port range that includes the maximum bound. Valid values are from 1 to 65535.<br /> Default value: 3200.
HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note *611361 - Hostnames of SAP ABAP Platform servers*
PROFILE |  The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles) <br /> Default value: "bx2-4x16"
IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images).<br /> Default value: ibm-redhat-7-6-amd64-sap-applications-3
VOL1 [number] | Volume 1 Size*. <br /> Default value: 32 GB.
VOL2 [number] | Volume 2 Size*. <br /> Default value: 32 GB.
VOL3 [number] | Volume 3 Size*. <br /> Default value: 64 GB.
VOL4 [number] | Volume 4 Size*. <br /> Default value: 128 GB.
VOL5 [number] | Volume 5 Size*. <br /> Default value: 256 GB.

**SAP input parameters**

Edit your SAP system configuration variables that will be passed to the ansible automated deployment:

```shell
##SAP system configuration
sap_sid	= "DB1"
sap_ci_instance_number = "00"
sap_ascs_instance_number = "01"

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
sap_master_password | Common password for all users that are created during the installation (Sensitive* value). | <ul><li>It must be 8 to 14 characters long</li><li>It must contain at least one digit (0-9)</li><li>It must not contain \ (backslash) and " (double quote)</li></ul>
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

**Obs***: <br />
- Sensitive - The variable value is not displayed in your tf files details after terrafrorm plan&apply commands.<br />
- VOL[number] | The sizes for the disks in GB that are to be attached to the VSI and used by SAP.<br />
- The following variables should be the same like the bastion ones: REGION, ZONE, VPC, SUBNET, SECURITYGROUP.

## VPC Configuration

The Security Rules are the following:
- Allow all traffic in the Security group
- Allow all outbound traffic
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)
- Option to Allow inbound TCP traffic with a custom port or a range of ports.



## Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `integration.tf` - contains the integration code that brings the SAP variabiles from Terraform to Ansible.
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.
 - `output.tf` - contains the code for the information to be displayed after the VSI is created (Hostname, Private IP, Public IP)



## Steps to reproduce:

For initializing terraform:

```shell
terraform init
```

For planning phase:

```shell
terraform plan --out plan1
# you will be asked for the following sensitive variables: 'ibmcloud_api_key'  and  'sap_master_password'.
```

For apply phase:

```shell
terraform apply
```

For destroy:

```shell
terraform destroy
# you will be asked for the following sensitive variables as a destroy confirmation phase:
'ibmcloud_api_key'  and  'sap_master_password'.
```


### Related links:

- [See how to create a BASTION/STORAGE VSI for SAP in IBM Schematics](https://github.ibm.com/workload-eng-services/SAP/tree/dev/ibm-schematics/sapbastionsetup-sch)
