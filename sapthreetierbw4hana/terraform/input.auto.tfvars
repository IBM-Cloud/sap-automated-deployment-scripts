# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-7945f2b4-06f2-4276-8d8f-d40922a8686d" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" ]

# SAP Database VSI variables:
DB-HOSTNAME		= "sapbw4db"
DB-PROFILE		= "mx2-16x128"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-hana-1"

# SAP APPs VSI variables:
APP-HOSTNAME	= "sapbw4app"
APP-PROFILE		= "bx2-4x16"
APP-IMAGE		= "ibm-redhat-7-6-amd64-sap-applications-1"

#HANA DB configuration
hana_sid = "HDB"
hana_sysno = "00"
hana_master_password = ""
hana_system_usage = "custom"
hana_components = "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"

#SAP system configuration
sap_sid = "B4A"
sap_ascs_instance_number = "01"
sap_ci_instance_number = "00"
sap_master_password = ""

# Number of concurrent jobs used to load and/or extract archives to HANA Host
hdb_concurrent_jobs = "6"

#SAP S4HANA APP Installation kit path
kit_sapcar_file = "/storage/BW4HANA/SAPCAR_1010-70006178.EXE"
kit_swpm_file = "/storage/BW4HANA/SWPM20SP09_4-80003424.SAR"
kit_sapexe_file = "/storage/BW4HANA/SAPEXE_400-80004393.SAR"
kit_sapexedb_file = "/storage/BW4HANA/SAPEXEDB_400-80004392.SAR"
kit_igsexe_file = "/storage/BW4HANA/igsexe_13-80003187.sar"
kit_igshelper_file = "/storage/BW4HANA/igshelper_17-10010245.sar"
kit_saphotagent_file = "/storage/BW4HANA/SAPHOSTAGENT51_51-20009394.SAR"
kit_hdbclient_file = "/storage/BW4HANA/IMDB_CLIENT20_009_28-80002082.SAR"
kit_bw4hana_export = "/storage/BW4HANA/export"

