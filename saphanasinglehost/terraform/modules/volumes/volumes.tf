resource "ibm_is_volume" "swap" {
  name		= "${var.HOSTNAME}-swap"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.SWAP
}

resource "ibm_is_volume" "vol1" {
  name		= "${var.HOSTNAME}-vol1"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL1
}

resource "ibm_is_volume" "vol2" {
  name		= "${var.HOSTNAME}-vol2"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL2
}

resource "ibm_is_volume" "vol3" {
  name		= "${var.HOSTNAME}-vol3"
  profile	= "10iops-tier"
  zone		= var.ZONE
  capacity	= var.VOL3
}

output "volumes_list" {
  value       = [ ibm_is_volume.vol1.id , ibm_is_volume.vol2.id , ibm_is_volume.vol3.id ]
}