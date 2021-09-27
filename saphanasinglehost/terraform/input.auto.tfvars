# General VPC variables:
REGION			= "eu-gb"
ZONE			= "eu-gb-1"
VPC			= "ic4sap"
SECURITYGROUP		= "elitism-headgear-wince-overstep"
SUBNET			= "ic4sap-subnet"
HOSTNAME		= "saphanadb"
PROFILE			= "mx2-16x128"
IMAGE			= "ibm-redhat-7-6-amd64-sap-hana-1"
SSH_KEYS		= [ "r018-9bec9e0b-81da-4013-85a0-68167f0e877f" , "r018-00923c15-e5ea-4487-88c7-bd3ac8d8762c" , "r018-f82adb4b-66c2-4203-9ab5-b4125300ad22" , "r018-d64cff17-3d9d-4161-96a6-4a3f400f085f"]
VOL1			= "500"
VOL2			= "500"
VOL3			= "500"

#HANA DB configuration
hana_sid = "HN1"
hana_sysno = "00"
hana_master_password = ""
hana_system_usage = "custom"  # default	value is: "custom"
hana_components = "server"    # default	value is: "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"
