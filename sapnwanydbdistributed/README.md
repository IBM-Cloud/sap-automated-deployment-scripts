# Terraform Framework,  2- and 3-tier for SAP VPC application stack deployments

This is an Automatic Framework Terraform IAC deployment of SAP certified IaaS with necessary storage, network configurations and OS SAP prerequisites basic configs.

The VPC contains one subnet and one security group having three rules:
- Allow all outbound traffic from the VSI
- Allow inbound DNS traffic (UDP port 53)
- Allow inbound SSH traffic (TCP port 22)

The VSIs are configured with Red Hat Enterprise Linux 7.x for SAP Applications (amd64) and they have: at least two SSH keys configured to access as root user and the following storage volumes created for DB and SAP APP VSI:

DB VSI Disks:
- 1 x 32 GB disk with 10 IOPS / GB - DATA (DB LOG)
- 1x 64 GB disk with 10 IOPS / GB - DATA (DB ARCHIVE LOG)
- 1 x 128/256 GB disk with 10 IOPS / GB - DATA
- 1x 40 GB disk with 10 IOPS / GB - SWAP

SAP APPs VSI Disks:
- 1 x 128 GB disk with 10 IOPS / GB - DATA
- 1x 40 GB disk with 10 IOPS / GB - SWAP

For the script configuration add your IBM Cloud API Key in `terraform.tfvars`.
Then edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and disk sizes in `input.auto.tfvars` like so:
```shell
# General VPC variables:
REGION        = "eu-de" # default value
ZONE          = "eu-de-2" # default value
VPC           = "ic4sap"
SECURITYGROUP = "ic4sap-securitygroup"
SUBNET        = "ic4sap-subnet"
SSH_KEYS      = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
PROFIL        = "bx2-4x16" # default value
IMAGE         = "ibm-redhat-7-6-amd64-sap-applications-1" # default value

# SAP Database VSI variables:
DB-HOSTNAME   = "ep12db"
SWAP-DB       = "40"  # default value
VOL1-DB       = "32"  # default value
VOL2-DB       = "64"  # default value
VOL3-DB       = "128" # default value


# SAP APPs VSI variables:
APP-HOSTNAME  = "ep12app" # default value
SWAP-APP      = "40"        # default value
VOL1-APP      = "128"       # default value
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
