resource "ibm_is_volume" "swap-db" {
  name		= "${var.HOSTNAME}-swap-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.SWAP-DB
}

resource "ibm_is_volume" "vol1-db" {
  name		= "${var.HOSTNAME}-vol1-db"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL1-DB
}

output "volumes_list_db" {
  value       = [ ibm_is_volume.swap-db.id , ibm_is_volume.vol1-db.id ]
}
