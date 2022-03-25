# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" , "r010-5cfdb578-fc66-4bf7-967e-f5b4a8d03b89" , "r010-7b85d127-7493-4911-bdb7-61bf40d3c7d4" , "r010-d941534b-1d30-474e-9494-c26a88d4cda3" , "r010-e372fc6f-4aef-4bdf-ade6-c4b7c1ad61ca" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "sapjavdb"
DB-PROFILE		= "mx2-16x128"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-hana-1"

# SAP APPs VSI variables:
APP-HOSTNAME	= "sapjavci"
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
sap_sid = "JV1"
sap_scs_instance_number = "01"
sap_ci_instance_number = "00"

#SAP S4HANA APP Installation kit path
kit_sapcar_file = "/storage/NW75HDB/SAPCAR_1010-70006178.EXE"
kit_swpm_file = "/storage/NW75HDB/SWPM10SP31_7-20009701.SAR"
kit_sapexe_file = "/storage/NW75HDB/SAPEXE_801-80002573.SAR"
kit_sapexedb_file = "/storage/NW75HDB/SAPEXEDB_801-80002572.SAR"
kit_igsexe_file = "/storage/NW75HDB/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/NW75HDB/igshelper_17-10010245.sar"
kit_saphotagent_file = "/storage/NW75HDB/SAPHOSTAGENT51_51-20009394.SAR"
kit_hdbclient_file = "/storage/NW75HDB/IMDB_CLIENT20_009_28-80002082.SAR"
kit_sapjvm_file = "/storage/NW75HDB/SAPJVM8_73-80000202.SAR"
kit_java_export = "/storage/NW75HDB/export"
