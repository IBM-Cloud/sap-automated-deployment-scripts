# Three Tier SAP S/4 Hana Terraform Framework with Hana 2.0 Application  Stack Deployment

This is an Automatic Framework Terraform IAC deployment of SAP certified IaaS with necessary storage, network configurations and OS SAP prerequisites basic configs.

The VPC contains one subnet and one security group having three rules:
- Allow all traffic in the Security group
- Allow all outbound traffic
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)

The VSIs are configured with Red Hat Enterprise Linux 7.6 for SAP HANA (amd64) for DB server and Red Hat Enterprise Linux 7.x for SAP Applications (amd64) for APP server and they have: at least two SSH keys configured to access as root user and the following storage volumes created for DB and SAP APP VSI:

HANA DB VSI Disks:
- 3 x 500 GB disks with 10000 IOPS - DATA

SAP APPs S/4 VSI Disks:
- 1x 40 GB disk with 10 IOPS / GB - SWAP
- 1 x 128 GB disk with 10 IOPS / GB - DATA


For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.
Then edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and disk sizes in `input.auto.tfvars` like so:

```shell
# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-7945f2b4-06f2-4276-8d8f-d40922a8686d" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "is110db"
DB-PROFILE		= "mx2-16x128" 
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-hana-1" # For any manual change in the terraform code, you have to make sure that you use a certified image based on the SAP NOTE: 2927211.

# SAP APPs VSI variables:
APP-HOSTNAME	= "is110apps"
APP-PROFILE		= "bx2-4x16"
APP-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-1" # For any manual change in the terraform code, you have to make sure that you use a certified image based on the SAP NOTE: 2927211.
......
```

Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.


 ## VPC Configuration

 The scripts create a new VPC with Subnet, Security Group and Security rules.
 If you want to use an existing VPC with Subnet, Security Group and Security rules use the `sapnwanydbdistributed/main.tf` file as below and add the names to `input.auto.tfvars`

 ```shell
module "vpc" {
# source		= "./modules/vpc"   		# Uncomment only this line for creating a NEW VPC #
  source		= "./modules/vpc/existing"	# Uncomment only this line to use an EXISTING VPC #

 ```


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
