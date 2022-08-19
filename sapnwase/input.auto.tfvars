#Infra VPC variables
REGION = "eu-de"
ZONE = "eu-de-3"
VPC = "ic4sap" # EXISTING Security group name
SECURITY_GROUP = "ic4sap-securitygroup" # EXISTING Security group name
SUBNET = "ic4sap-fra3" # EXISTING Subnet name
HOSTNAME = "sapnwase"
PROFILE = "bx2-4x16"
IMAGE = "ibm-redhat-8-4-amd64-sap-applications-2"
RESOURCE_GROUP = "wes-automation" # EXISTING Resource Group for VSI and volumes
SSH_KEYS                = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" , "r010-5cfdb578-fc66-4bf7-967e-f5b4a8d03b89" , "r010-7b85d127-7493-4911-bdb7-61bf40d3c7d4" , "r010-d941534b-1d30-474e-9494-c26a88d4cda3" , "r010-e372fc6f-4aef-4bdf-ade6-c4b7c1ad61ca" ]

##SAP system configuration
sap_sid	= "NWD"
sap_ci_instance_number = "00"
sap_ascs_instance_number = "01"

#Kits paths
kit_sapcar_file = "/storage/NW75SYB/SAPCAR_1010-70006178.EXE"
kit_swpm_file =  "/storage/NW75SYB/SWPM10SP31_7-20009701.SAR"
kit_saphotagent_file = "/storage/NW75SYB/SAPHOSTAGENT51_51-20009394.SAR"
kit_sapexe_file = "/storage/NW75SYB/SAPEXE_900-80002573.SAR"
kit_sapexedb_file = "/storage/NW75SYB/SAPEXEDB_900-80002616.SAR"
kit_igsexe_file = "/storage/NW75SYB/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75SYB/igshelper_17-10010245.sar"
kit_ase_file = "/storage/NW75SYB/51055443_1.ZIP"
kit_export_dir = "/storage/NW75SYB/EXP"
