# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"                        # EXISTING Security group name
SECURITYGROUP	= "ic4sap-securitygroup"      # EXISTING Security group name
SUBNET			= "ic4sap-subnet"               # EXISTING Subnet name
ADD_OPEN_PORTS = "no"                       # To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options
OPEN_PORT_MINIMUM = "3203"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
OPEN_PORT_MAXIMUM = "3203"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
SSH_KEYS                = [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-e372fc6f-4aef-4bdf-ade6-c4b7c1ad61ca" , "r010-09325e15-15be-474e-9b3b-21827b260717" , "r010-5cfdb578-fc66-4bf7-967e-f5b4a8d03b89" , "r010-7b85d127-7493-4911-bdb7-61bf40d3c7d4" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-d941534b-1d30-474e-9494-c26a88d4cda3" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "saps4hnmar1"
DB-PROFILE		= "mx2-16x128"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-hana-3"

# SAP APPs VSI variables:
APP-HOSTNAME	= "saps4apmar1"
APP-PROFILE		= "bx2-4x16"
APP-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-3"

#HANA DB configuration
hana_sid = "HDB"
hana_sysno = "00"
hana_system_usage = "custom"
hana_components = "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"

#SAP system configuration
sap_sid = "S4A"
sap_ascs_instance_number = "01"
sap_ci_instance_number = "03"

# Number of concurrent jobs used to load and/or extract archives to HANA Host
hdb_concurrent_jobs = "23"

#SAP S4HANA APP Installation kit path
kit_sapcar_file = "/storage/S4HANA/SAPCAR_1010-70006178.EXE"
kit_swpm_file = "/storage/S4HANA/SWPM20SP09_4-80003424.SAR"
kit_sapexe_file = "/storage/S4HANA/SAPEXE_100-70005283.SAR"
kit_sapexedb_file = "/storage/S4HANA/SAPEXEDB_100-70005282.SAR"
kit_igsexe_file = "/storage/S4HANA/igsexe_1-70005417.sar"
kit_igshelper_file = "/storage/S4HANA/igshelper_17-10010245.sar"
kit_saphotagent_file = "/storage/S4HANA/SAPHOSTAGENT51_51-20009394.SAR"
kit_hdbclient_file = "/storage/S4HANA/IMDB_CLIENT20_009_28-80002082.SAR"
kit_s4hana_export = "/storage/S4HANA/export"
