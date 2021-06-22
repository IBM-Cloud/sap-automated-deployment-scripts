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

output "volumes_list" {
  value       = [ ibm_is_volume.swap.id , ibm_is_volume.vol1.id ]
}