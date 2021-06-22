# IBM Sample for VPC and VSI automatic deployment with SAP certified storage and network configuration using Terraform

This is a minimal terraform script for deploying a VPC and a VSI with SAP certified storage and network configuration.
The VPC contains one subnet and one security group having three rules:
- Allow all outbound traffic from the VSI
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)

The VSI is configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64), has two SSH keys configured to access as root user on SSH, and two storage volumes created:
- One Swap volume of 16Gb
- One data volume of 10Gb

For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.
Then edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and disk sizes in `input.auto.tfvars` like so:
```shell
ZONE			= Cloud Zone Default: eu-de-1
VPC			= VPC name Default: test-vpc
SECURITYGROUP		= Security group name Default: test-securitygroup
SUBNET			= Subnet name Default: test-subnet
HOSTNAME		= VSI Hostname Default: test-vsi
PROFILE			= VSI Profile Default: bx2-4x16
IMAGE			= VSI OS Image Default: ibm-redhat-7-6-amd64-sap-applications-1
SSH_KEYS		= SSH Keys ID list to access the VSI
SWAP			= SWAP Size Default: 16
VOL1			= Volume 1 Size Default: 10
```

Files description and structure:
 - `modules` - directory containing the terraform modules
 - `input.auto.tfvars` - contains the variables that will need to be edited by the user to customize the solution
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.


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
