# Automation script for SAP solutions using  a BASTION&STORAGE setup deployment throught Terraform and IBM Schematics.


## Description
This Terraform example for IBM Cloud Schematics demonstrates how to  perform an automated deployment of  **SAP BASTION and STORAGE setup** on top of **Red Hat Enterprise Linux 8.4**. It shows how to deploy an IBM Cloud Gen2 VPC with a bastion host with secure remote SSH access.

The intended usage is for remote software installation using Terraform remote-exec and Ansible playbooks executed by Schematics.

The example and Terraform modules only seek to implement a 'reasonable' set of best practices for bastion host configuration. Your own Organization could have additional requirements that should be applied before the deployment.


**It contains:**  
- Terraform scripts for deploying a VPC, Subnet, Security Group with rules, a volume and a VSI.
- Bash scripts to install  the prerequisites for SAP BASTION&STORAGE VSI and other SAP solutions.

## Prerequisites
In order to apply the steps from this article, you should have a general understanding of IBM VPC and VSIs. To run the example in IBM Cloud Schematics, you will also need an [IBM Cloud account](https://cloud.ibm.com/registration?cm_sp=ibmdev-_-developer-articles-_-cloudreg). The deployed resources  are chargeable.

## IBM Cloud API Key
For the script configuration add your IBM Cloud API Key variable under IBM SCHEMATICS,  "SETTINGS" menu, editing the variable "ibmcloud_api_key" and  using sensitive option.

## VSI Configuration
The VSI is configured with Red Hat Enterprise Linux 8.4 (amd64), has a minimal of two SSH keys configured to be accessed by the root user and one storage volume as described below,  to be filled in, under the "SETTINGS" menu, variables fields in IBM Schematics.
The storage volume is mounted under "/storage" path, and can be accessed with the user "storage" via  your "private_ssh_key" added as a variable.

**Software configuration:**
- Terraform - an open-source infrastructure as code software tool created by HashiCorp
- Ansible - an open-source software provisioning and configuration management tool.
- The IBM Cloud® Command Line Interface provides commands for managing resources in IBM Cloud.


## SAP Bastion Input variables
The solution is configured by editing your variables in your workspace:
Edit your VPC, Subnet, Security group, Hostname, Profile, Image, SSH Keys and starting with minimal recommended disk sizes like so:

Parameter | Description
----------|------------
ibmcloud_api_key | IBM Cloud API key (Sensitive* value).
private_ssh_key | Input id_rsa private key content (Sensitive* value).
REGION | The cloud region where to deploy the solution. <br /> The regions and zones for VPC are listed [here](https://cloud.ibm.com/docs/containers?topic=containers-regions-and-zones#zones-vpc). <br /> Review supported locations in IBM Cloud Schematics [here](https://cloud.ibm.com/docs/schematics?topic=schematics-locations).<br /> Sample value: eu-de.
ZONE | The cloud zone where to deploy the solution. <br /> Sample value: eu-de-2.
VPC_EXISTS | Please mention if the chosen VPC exists or not (use 'yes' or 'no'). If you choose 'no' as an option, a new VPC will be created.
SUBNET_EXISTS | Please mention if the chosen SUBNET/SECURITYGROUP exist or not (use 'yes' or 'no'). If you choose 'no' as an option, a new SUBNET/SECURITYGROUP with OPEN PORTS will be created in the existing VPC.
ADD_OPEN_PORTS_IN_NEW_SUBNET | To create new port/s only if a NEW SUBNET is created, use 'yes' or 'no'.
OPEN_PORT_MINIMUM | (Required, Integer) The TCP port range that includes the minimum bound. Valid values are from 1 to 65535.
OPEN_PORT_MAXIMUM | (Required, Integer) The TCP port range that includes the maximum bound. Valid values are from 1 to 65535.
VPC | The name of the VPC. The list of VPCs is available [here](https://cloud.ibm.com/vpc-ext/network/vpcs)
SUBNET | The name of the Subnet. The list of Subnets is available [here](https://cloud.ibm.com/vpc-ext/network/subnets)
SECURITYGROUP | The name of the Security Group. The list of Security Groups is available [here](https://cloud.ibm.com/vpc-ext/network/securityGroups)
HOSTNAME | The Hostname for the VSI. The hostname must have up to 13 characters.
PROFILE |  The profile used for the VSI. A list of profiles is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-profiles) <br /> Default value: "bx2-2x8"
IMAGE | The OS image used for the VSI. A list of images is available [here](https://cloud.ibm.com/docs/vpc?topic=vpc-about-images).<br /> Default value: ibm-redhat-8-4-minimal-amd64-1
SSH_KEYS | List of SSH Keys IDs that are allowed to SSH as root to the VSI. Can contain one or more IDs. The list of SSH Keys is available [here](https://cloud.ibm.com/vpc-ext/compute/sshKeys). <br /> Sample input (use your own SSH IDS from IBM Cloud):<br /> [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1 [number] | The size for the disk in GB to be attached to the  BASTION VSI as storage for the SAP deployment kits. The mount point for the new volume is: "/storage". <br /> Default value: 100 GB.

Obs: Sensitive* - The variable value is not displayed in your workspace details after it is stored.


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
 - `main.tf` - contains the configuration of the VSI for SAP single tier deployment.
 - `output.tf` - contains the code for the information to be displayed after the VSI is created (Hostname, Private IP, Public IP)
 - `provider.tf` - contains the IBM Cloud Provider data in order to run `terraform init` command.
 - `terraform.tfvars` - contains the IBM Cloud API key referenced in `provider.tf`
 - `variables.tf` - contains variables for the VPC and VSI
 - `versions.tf` - contains the minimum required versions for terraform and IBM Cloud provider.



## Steps to reproduce:

1.  Be sure that you have the [required IBM Cloud IAM
    permissions](https://cloud.ibm.com/docs/vpc?topic=vpc-managing-user-permissions-for-vpc-resources) to
    create and work with VPC infrastructure and you are [assigned the
    correct
    permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to
    create the workspace and deploy resources.
2.  [Generate an SSH
    key](https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys).
    The SSH key is required to access the provisioned VPC virtual server
    instances via the bastion host. After you have created your SSH key,
    make sure to [upload this SSH key to your IBM Cloud
    account](https://cloud.ibm.com/docs/vpc-on-classic-vsi?topic=vpc-on-classic-vsi-managing-ssh-keys#managing-ssh-keys-with-ibm-cloud-console) in
    the VPC region and resource group where you want to deploy this
    example
3.  Create the Schematics workspace:
   1.  From the IBM Cloud menu
    select [Schematics](https://cloud.ibm.com/schematics/overview).
       - Click Create a workspace.   
       - Enter a name for your workspace.   
       - Click Create to create your workspace.
    2.  On the workspace **Settings** page, enter the URL of this example in
    the Schematics examples Github repository.
     - Select the Terraform version: Terraform 0.12.
     - Click **Save template information**.
     - In the **Input variables** section, review the default input
        variables and provide alternatives if desired. The only
        mandatory parameter is the name given to the SSH key that you
        uploaded to your IBM Cloud account.
      - Click **Save changes**.

4.  From the workspace **Settings** page, click **Generate plan** 
5.  Click **View log** to review the log files of your Terraform
    execution plan.
6.  Apply your Terraform template by clicking **Apply plan**.
7.  Review the log file to ensure that no errors occurred during the
    provisioning, modification, or deletion process.

The output of the Schematics Apply Plan will list the public/private IP addresses
of the bastion host, the hostname and the VPC.  

## Outputs example:
FLOATING-IP = "161.156.60.19"<br />
HOSTNAME = "sapbastionsch"<br />
PRIVATE-IP = "10.243.6.36"<br />
VPC = "sapvpcbastion"<br />

### Related links:
- [Securely Access Remote Instances with a Bastion Host](https://www.ibm.com/cloud/blog/tutorial-securely-access-remote-instances-with-a-bastion-host)
- [IBM Cloud Schematics](https://www.ibm.com/cloud/schematics)
