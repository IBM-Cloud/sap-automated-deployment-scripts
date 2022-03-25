# General VPC variables:
REGION			= "eu-de"
ZONE			= "eu-de-2"
VPC				= "ic4sap"                        # EXISTING VPC name
SECURITYGROUP	= "ic4sap-securitygroup"      # EXISTING Security group name
SUBNET			= "ic4sap-subnet"               # EXISTING Subnet name
ADD_OPEN_PORTS = "no"                       # To create new open port/s on the EXISTING SECURITYGROUP, choose 'yes' or 'no' as options
OPEN_PORT_MINIMUM = "3200"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
OPEN_PORT_MAXIMUM = "3200"                  # This variables will be created only if ADD_OPEN_PORTS = "yes"
HOSTNAME		= "saphadbm"
PROFILE			= "mx2-16x128"
IMAGE			= "ibm-redhat-7-6-amd64-sap-hana-3"
SSH_KEYS		= [ "r010-57bfc315-f9e5-46bf-bf61-d87a24a9ce7a" , "r010-3fcd9fe7-d4a7-41ce-8bb3-d96e936b2c7e" ]
VOL1			= "500"
VOL2			= "500"
VOL3			= "500"

#HANA DB configuration
hana_sid = "HN1"
hana_sysno = "00"
hana_system_usage = "custom"  # default	value is: "custom"
hana_components = "server"    # default	value is: "server"

#SAP HANA Installation kit path
kit_saphana_file = "/storage/HANADB/51054623.ZIP"
