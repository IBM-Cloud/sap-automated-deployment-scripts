# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"
SECURITYGROUP	= "ic4sap-securitygroup"
SUBNET			= "ic4sap-subnet"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" , "r010-771e15dd-8081-4cca-8844-445a40e6a3b3" , "r010-09325e15-15be-474e-9b3b-21827b260717" , "r010-5cfdb578-fc66-4bf7-967e-f5b4a8d03b89" , "r010-7b85d127-7493-4911-bdb7-61bf40d3c7d4" , "r010-d941534b-1d30-474e-9494-c26a88d4cda3" , "r010-e372fc6f-4aef-4bdf-ade6-c4b7c1ad61ca" ]

# HANA Database VSI variables:
DB-HOSTNAME		= "saphdbprimary"
DBSTANDBY-HOSTNAME	= "saphdbstandby"
DB-PROFILE		= "mx2-16x128"
DB-IMAGE		= "ibm-redhat-7-6-amd64-sap-hana-1"

#HANA system configuration
hana_sid = "HDB"
hana_sysno = "00"
hana_system_usage = "custom"
hana_components = "server"

#HANA system replication
replication_mode = "sync" #[sync|syncmem|async]
operation_mode = "delta_datashipping" #[delta_datashipping|logreplay|logreplay_readaccess]

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"
