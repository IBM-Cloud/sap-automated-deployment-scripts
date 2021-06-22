# IBM SAP Cloud Solution Automated Deployment scripts: Virtual Private Cloud

The templates in this repo are used to deploy different SAP scenarious like:

- [Automatic deployment of SAP (NW7.X/DB2 on Unix) certified IaaS with storage and network configurations using Reference Architecture - single tier](https://github.com/IBM-Cloud/sap-automated-deployment-scripts/tree/dev/sapsingletierdb2)

The main repo contains different directories with examples of using various SAP IBM Cloud services with Terraform&Ansible.  Each of the examples have their own README containing more details on what the example does.

To run any example, clone the repository and run terraform apply within the example's own directory.

For example:
`
$ git clone git@github.com:IBM-Cloud/sap-automated-deployment-scripts.git
$ cd sapsingletierdb2/terraform
$ terraform apply
...
`

**References and IBM Cloud Solution tutorials that could be used for SAP deployments in a Virtual Private Cloud:**

- [Preparing your deployment server with terraform&ansible](https://github.com/IBM-Cloud/terraform-provider-ibm)

- [Creating a bastion server in your VPC](https://github.com/IBM-Cloud/vpc-tutorials/tree/master/vpc-secure-management-bastion-server)
