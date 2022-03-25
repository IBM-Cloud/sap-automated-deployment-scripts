# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"                        # EXISTING Security group name
SECURITYGROUP	= "ic4sap-securitygroup"      # EXISTING Security group name
SUBNET			= "ic4sap-subnet"               # EXISTING Subnet name
ADD_OPEN_PORTS = "no"                       # To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options
OPEN_PORT_MINIMUM = "3206"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
OPEN_PORT_MAXIMUM = "3206"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
SSH_KEYS                = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-e372fc6f-4aef-4bdf-ade6-c4b7c1ad61ca" , "r010-09325e15-15be-474e-9b3b-21827b260717" , "r010-5cfdb578-fc66-4bf7-967e-f5b4a8d03b89" , "r010-7b85d127-7493-4911-bdb7-61bf40d3c7d4" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-d941534b-1d30-474e-9494-c26a88d4cda3" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "sapnwdb2mar8"
DB-PROFILE		= "bx2-4x16"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-3"

# SAP APPs VSI variables:
APP-HOSTNAME	= "sapnwappmar8"
APP-PROFILE		= "bx2-4x16"
APP-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-3"

#SAP system configuration
sap_sid = "NWA"
sap_ascs_instance_number = "01"
sap_ci_instance_number = "06"

#Kits paths
kit_sapcar_file = "/storage/NW75DB2/SAPCAR_1010-70006178.EXE"
kit_swpm_file =  "/storage/NW75DB2/SWPM10SP31_7-20009701.SAR"
kit_saphotagent_file = "/storage/NW75DB2/SAPHOSTAGENT51_51-20009394.SAR"
kit_sapexe_file = "/storage/NW75DB2/SAPEXE_800-80002573.SAR"
kit_sapexedb_file = "/storage/NW75DB2/SAPEXEDB_800-80002603.SAR"
kit_igsexe_file = "/storage/NW75DB2/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75DB2/igshelper_17-10010245.sar"
kit_export_dir = "/storage/NW75DB2/51050829"
kit_db2_dir = "/storage/NW75DB2/51051007/DB2_FOR_LUW_10.5_FP7SAP2_LINUX_"
kit_db2client_dir = "/storage/NW75DB2/51051049"
