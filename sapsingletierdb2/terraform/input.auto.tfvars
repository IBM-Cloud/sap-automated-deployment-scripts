#Infra VPC variables
ZONE			= "eu-de-2"
VPC			= "sap"
SECURITYGROUP	= "sap-securitygroup"
SUBNET			= "sap-subnet"
HOSTNAME		= "db2saps1"
PROFILE			= "bx2-4x16"
IMAGE			= "ibm-redhat-7-6-amd64-sap-applications-1"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1			= "32"
VOL2			= "32"
VOL3			= "64"
VOL4			= "128"
VOL5			= "256"

##SAP system configuration
sap_sid	= "id1"
sap_ci_instance_number = "00"
sap_ascs_instance_number = "01"
sap_master_password = ""

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
