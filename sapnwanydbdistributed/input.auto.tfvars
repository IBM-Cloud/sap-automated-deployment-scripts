# General VPC variables:
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-7945f2b4-06f2-4276-8d8f-d40922a8686d" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" ]
PROFILE			= "bx2-4x16"
IMAGE			= "ibm-redhat-7-6-amd64-sap-applications-1"

# SAP Database VSI variables:
HOSTNAME		= "ep12m1"
SWAP-DB			= "40"
VOL1-DB			= "10"


# SAP APPs VSI variables:
HOSTNAME-APP	= "ep12app1"
SWAP-APP			= "40"
VOL1-APP			= "10"
