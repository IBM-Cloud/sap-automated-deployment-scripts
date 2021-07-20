resource "ibm_is_volume" "swap-db" {
  name		= "${var.HOSTNAME-DB}-swap-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.SWAP-DB
}

resource "ibm_is_volume" "vol1-db" {
  name		= "${var.HOSTNAME-DB}-vol1-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL1-DB
}


resource "ibm_is_volume" "vol2-db" {
  name		= "${var.HOSTNAME-DB}-vol2-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL2-DB
}


resource "ibm_is_volume" "vol3-db" {
  name		= "${var.HOSTNAME-DB}-vol3-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL3-DB
}


resource "ibm_is_volume" "swap-app" {
  name		= "${var.HOSTNAME-APP}-swap-app"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.SWAP-APP
}

resource "ibm_is_volume" "vol1-app" {
  name		= "${var.HOSTNAME-APP}-vol1-app"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL1-APP
}


output "volumes_list_db" {
  value       = [ ibm_is_volume.swap-db.id , ibm_is_volume.vol1-db.id, ibm_is_volume.vol2-db.id, ibm_is_volume.vol3-db.id ]
}


output "volumes_list_app" {
  value       = [ ibm_is_volume.swap-app.id , ibm_is_volume.vol1-app.id ]
}
