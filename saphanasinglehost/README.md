# Automation script for SAP HANA 2.0 DB installation using Terraform and Ansible integration.


## Description
This solution will perform automated deployment of  **SAP HANA 2.0 DB** on top of **Red Hat Enterprise Linux 7.6 for SAP HANA**.

It contains:  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules and a VSI.
- Ansible scripts to configure SAP HANA 2.0 DB installation.
Please note that Ansible is started by Terraform and must be available on the same host.

## Installation media
SAP HANA installation media used for this deployment is the default one for **SAP HANA, platform edition 2.0 SPS05** available at SAP Support Portal under *INSTALLATION AND UPGRADE* area and it has to be provided manually in the input parameter file.

## IBM Cloud API Key
For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.

## VSI Configuration
The VSI is configured with Red Hat Enterprise Linux 7.6 for SAP HANA (amd64), has two SSH keys configured to access as root user on SSH and 3 storage volumes as described below in
the file `input.auto.tfvars`

## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and starting with minimal recommended disk sizes like so:
```shell
# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
HOSTNAME		= "saphanahost"
PROFILE			= "mx2-16x128"
IMAGE			= "ibm-redhat-7-6-amd64-sap-hana-1"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1			= "500"
VOL2			= "500"
VOL3			= "500"
```

Parameter | Description
----------|------------
REGION | The cloud region where to deploy the solution. The regions and zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc)
ZONE | The cloud zone where to deploy the solution
VPC | The name of the VPC. The list of VPCs is available [here](https://cloud.ibm.com/vpc-ext/network/vpcs)
SECURITYGROUP | The name of the Security Group. The list of Security Groups is available [here](https://cloud.ibm.com/vpc-ext/network/securityGroups)
SUBNET | The name of the Subnet. The list of Subnets is available [here](https://cloud.ibm.com/vpc-ext/network/subnets)
HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note [611361 - Hostnames of SAP ABAP Platform servers](https://launchpad.support.sap.com/#/notes/%20611361)
PROFILE | The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles)
IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images)
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The list of SSH Keys is available [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys)
VOL[number] | The sizes for the disks in GB to be attached to the VSI and used by SAP

Edit your SAP system configuration variables that will be passed to the ansible automated deployment:

```shell
#HANA DB configuration
hana_sid = "HDB"
hana_sysno = "00"
hana_master_password = ""
hana_system_usage = "custom"  # default	value is: "custom"
hana_components = "server"    # default	value is: "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"

```
**SAP input parameters:**

Parameter | Description | Requirements
----------|-------------|-------------
hana_sid | The SAP system ID identifies the SAP HANA system | <ul><li>Consists of exactly three alphanumeric characters</li><li>Has a letter for the first character</li><li>Does not include any of the reserved IDs listed in SAP Note 1979280</li></ul>|
hana_sysno | Specifies the instance number of the SAP HANA system| <ul><li>Two-digit number from 00 to 97</li><li>Must be unique on a host</li></ul>
hana_master_password | Common password for all users that are created during the installation | <ul><li>It must be 8 to 14 characters long</li><li>It must contain at least one digit (0-9)</li><li>It must not contain \ (backslash) and " (double quote)</li><li>Master Password must contain at least one upper-case character</li></ul>
hana_system_usage  | System Usage | Default: custom<br> Valid values: production, test, development, custom
hana_components | SAP HANA Components | Default: server<br> Valid values: all, client, es, ets, lcapps, server, smartda, streaming, rdsync, xs, studio, afl, sca, sop, eml, rme, rtl, trp
kit_saphana_file | Path to SAP HANA ZIP file | As downloaded from SAP Support Portal

## VPC Configuration

The scripts create a new VPC with Subnet, Security Group and Security rules.
If you want to use an existing VPC with Subnet, Security Group and Security rules use the `saphanasinglehost/terraform/main.tf` file as below and add the names to `input.auto.tfvars`

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


### Related links:

- [See full IBM Cloud Docs, single-tier virtual private cloud for SAP](https://cloud.ibm.com/docs/sap?topic=sap-create-terraform-single-tier-vpc-sap)
