# IBM SAP Cloud Solution Automated Deployment scripts: Virtual Private Cloud

The templates in this repo are used to deploy different SAP scenarios like:

- [Creating single-tier virtual private cloud for SAP by using Terraform](https://github.com/IBM-Cloud/sap-automated-deployment-scripts/tree/master/sapsingletiervpc)

- [Automatic deployment of SAP (NW7.X/DB2 on Unix) certified IaaS with storage and network configurations using Reference Architecture - single tier](https://github.com/IBM-Cloud/sap-automated-deployment-scripts/tree/master/sapsingletierdb2)


The main repo contains different directories with examples of using various SAP IBM Cloud services based on  Terraform&Ansible deployment tools.  Each of the examples have their own README containing more details on what the example does.

To run any example, clone the repository and run terraform apply within the example's own directory.

For example:
```
$ git clone git@github.com:IBM-Cloud/sap-automated-deployment-scripts.git
$ cd sap-automated-deployment-scripts/sapsingletierdb2/terraform
$ terraform apply
...
```

## Related links:

- [Preparing your deployment server with terraform&ansible](https://github.com/IBM-Cloud/terraform-provider-ibm)

- [Creating a bastion server in your VPC](https://github.com/IBM-Cloud/vpc-tutorials/tree/master/vpc-secure-management-bastion-server)
