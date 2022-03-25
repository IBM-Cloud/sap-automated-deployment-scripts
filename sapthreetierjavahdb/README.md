# Three Tier SAP JAVA on HANA DB Deployment


## Description
This solution will perform automated deployment of  **Three Tier SAP JAVA on HANA DB** on top of **Red Hat Enterprise Linux 7.6 for SAP**.

It contains:  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules and a VSI.
- Ansible scripts to isntall and configure a SAP JAVA primary application server and a HANA 2.0 DB node.
Please note that Ansible is started by Terraform and must be available on the same host.

## Installation media
SAP HANA installation media used for this deployment is the default one for **SAP HANA, platform edition 2.0 SPS05** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

SAP JAVA installation media used for this deployment is the default one for **SAP Netweaver 7.5** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

## VSI Configuration
The VSIs are configured with Red Hat Enterprise Linux 7.6 for SAP HANA (amd64) for DB server and Red Hat Enterprise Linux 7.x for SAP Applications (amd64) for JAVA APP server and they have: at least two SSH keys configured to access as root user and the following storage volumes created for DB and SAP APP VSI:

HANA DB VSI Disks:
- 3 x 500 GB disks with 10000 IOPS - DATA

SAP JAVA APP VSI Disks:
- 1 x 40 GB disk with 10 IOPS / GB - SWAP
- 1 x 128 GB disk with 10 IOPS / GB - DATA

## IBM Cloud API Key
Your IBM Cloud API Key will be asked interactively during terraform plan step.

## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys like so:

```shell
# General VPC variables:
REGION                  = "eu-de"
ZONE                    = "eu-de-2"
VPC                             = "ic4sap"
SECURITYGROUP   = "ic4sap-securitygroup"
SUBNET                  = "ic4sap-subnet"
SSH_KEYS                = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]

# SAP Database VSI variables:
DB-HOSTNAME             = "sapjavdb"
DB-PROFILE              = "mx2-16x128"
DB-IMAGE                = "ibm-redhat-7-6-amd64-sap-hana-1"

# SAP APPs VSI variables:
APP-HOSTNAME    = "sapjavci"
APP-PROFILE             = "bx2-4x16"
APP-IMAGE               = "ibm-redhat-7-6-amd64-sap-applications-3"
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
#HANA DB configuration
hana_sid = "HDB"
hana_sysno = "00"
hana_system_usage = "custom"
hana_components = "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"

#SAP system configuration
sap_sid = "JV1"
sap_scs_instance_number = "01"
sap_ci_instance_number = "00"

#SAP S4HANA APP Installation kit path
kit_sapcar_file = "/storage/NW75HDB/SAPCAR_1010-70006178.EXE"
kit_swpm_file = "/storage/NW75HDB/SWPM10SP31_7-20009701.SAR"
kit_sapexe_file = "/storage/NW75HDB/SAPEXE_801-80002573.SAR"
kit_sapexedb_file = "/storage/NW75HDB/SAPEXEDB_801-80002572.SAR"
kit_igsexe_file = "/storage/NW75HDB/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75HDB/igshelper_17-10010245.sar"
kit_saphotagent_file = "/storage/NW75HDB/SAPHOSTAGENT51_51-20009394.SAR"
kit_hdbclient_file = "/storage/NW75HDB/IMDB_CLIENT20_009_28-80002082.SAR"
kit_sapjvm_file = "/storage/NW75HDB/SAPJVM8_73-80000202.SAR"
kit_java_export = "/storage/NW75HDB/export"

```
**SAP input parameters:**

Parameter | Description | Requirements
----------|-------------|-------------
hana_sid | The SAP system ID identifies the SAP HANA system | <ul><li>Consists of exactly three alphanumeric characters</li><li>Has a letter for the first character</li><li>Does not include any of the reserved IDs listed in SAP Note 1979280</li></ul>|
hana_sysno | Specifies the instance number of the SAP HANA system| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
hana_system_usage  | System Usage | Default: custom<br> Valid values: production, test, development, custom
hana_components | SAP HANA Components | Default: server<br> Valid values: all, client, es, ets, lcapps, server, smartda, streaming, rdsync, xs, studio, afl, sca, sop, eml, rme, rtl, trp
kit_saphana_file | Path to SAP HANA ZIP file | As downloaded from SAP Support Portal
sap_sid | The SAP system ID <SAPSID> identifies the entire SAP system | <ul><li>Consists of exactly three alphanumeric characters</li><li>Has a letter for the first character</li><li>Does not include any of the reserved IDs listed in SAP Note 1979280</li></ul>
sap_scs_instance_number | Technical identifier for internal processes of SCS| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
sap_ci_instance_number | Technical identifier for internal processes of CI| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
hdb_concurrent_jobs | Number of concurrent jobs used to load and/or extract archives to HANA Host | Default: 6
kit_sapcar_file  | Path to sapcar binary | As downloaded from SAP Support Portal
kit_swpm_file | Path to SWPM archive (SAR) | As downloaded from SAP Support Portal
kit_sapexe_file | Path to SAP Kernel OS archive (SAR) | As downloaded from SAP Support Portal
kit_sapexedb_file | Path to SAP Kernel DB archive (SAR) | As downloaded from SAP Support Portal
kit_igsexe_file | Path to IGS archive (SAR) | As downloaded from SAP Support Portal
kit_igshelper_file | Path to IGS Helper archive (SAR) | As downloaded from SAP Support Portal
kit_saphostagent_file | Path to SAP Host Agent archive (SAR) | As downloaded from SAP Support Portal
kit_hdbclient_file | Path to HANA DB client archive (SAR) | As downloaded from SAP Support Portal
kit_sapjvm_file | Path to SAP JVM archive (SAR) | As downloaded from SAP Support Portal
kit_java_export | Path to JAVA Installation Export dir | The archives downloaded from SAP Support Portal should be present in this path

**SAP Master Password**
The password for the SAP system will be asked interactively during terraform plan step and will not be available after the deployment.

Parameter | Description | Requirements
----------|-------------|-------------
sap_master_password | Common password for all users that are created during the installation | <ul><li>It must be 8 to 14 characters long</li><li>It must contain at least one digit (0-9)</li><li>It must not contain \ (backslash) and " (double quote)</li></ul>

## VPC Configuration

The scripts create a new VPC with Subnet, Security Group and Security rules.
If you want to use an existing VPC with Subnet, Security Group and Security rules use the `sapthreetiers4hana/terraform/main.tf` file as below and add the names to `input.auto.tfvars`

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
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `output.tf` - contains the code for the information to be displayed after the VSI is created (Hostname, Private IP, Public IP)
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
