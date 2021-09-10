# Terraform Framework,  2- and 3-tier for SAP VPC application stack deployments


## Description
This is an Automatic Framework Terraform IAC deployment of SAP certified IaaS with necessary storage, network configurations and OS SAP prerequisites basic configs.

It contains:  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules and two VSIs.
- Ansible scripts to configure 2- and 3-tier for SAP VPC application stack deployments.
Please note that Ansible is started by Terraform and must be available on the same host.

## IBM Cloud API Key
For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.

## VSI Configuration
The VSIs are configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64) and they have: at least two SSH keys configured to access as root user and the following storage volumes created for DB and SAP APP VSI:

DB VSI Disks:
- 1x 40 GB disk with 10 IOPS / GB - SWAP
- 1 x 32 GB disk with 10 IOPS / GB - DATA (DB LOG)
- 1x 64 GB disk with 10 IOPS / GB - DATA (DB ARCHIVE LOG)
- 1 x 128/256 GB disk with 10 IOPS / GB - DATA

SAP APPs VSI Disks:
- 1x 40 GB disk with 10 IOPS / GB - SWAP
- 1 x 128 GB disk with 10 IOPS / GB - DATA


## Input parameter file
The solution is configured by editing your variables in the file `input.auto.tfvars`
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys like so:
```shell
# General VPC variables:
REGION        = "eu-de" # default value
ZONE          = "eu-de-2" # default value
VPC           = "ic4sap"
SECURITYGROUP = "ic4sap-securitygroup"
SUBNET        = "ic4sap-subnet"
PROFILE       = "bx2-4x16" # default value
IMAGE         = "ibm-redhat-7-6-amd64-sap-applications-1" # default value
SSH_KEYS      = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]

# SAP Database VSI variables:
DB-HOSTNAME   = "ep12db"

# SAP APPs VSI variables:
APP-HOSTNAME  = "ep12app" # default value
......
```

Parameter | Description
----------|------------
REGION | The cloud region where to deploy the solution. The regions and zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc)
ZONE | The cloud zone where to deploy the solution
VPC | The name of the VPC. The list of VPCs is available [here](https://cloud.ibm.com/vpc-ext/network/vpcs)
SECURITYGROUP | The name of the Security Group. The list of Security Groups is available [here](https://cloud.ibm.com/vpc-ext/network/securityGroups)
SUBNET | The name of the Subnet. The list of Subnets is available [here](https://cloud.ibm.com/vpc-ext/network/subnets)
PROFILE | The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles)
IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images)
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The list of SSH Keys is available [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys)
[DB/APP]-HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters as required by SAP. For more information on rules regarding hostnames for SAP systems, check SAP Note [611361 - Hostnames of SAP ABAP Platform servers](https://launchpad.support.sap.com/#/notes/%20611361)

## VPC Configuration

The scripts create a new VPC with Subnet, Security Group and Security rules.
If you want to use an existing VPC with Subnet, Security Group and Security rules use the `sapnwanydbdistributed/main.tf` file as below and add the names to `input.auto.tfvars`

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