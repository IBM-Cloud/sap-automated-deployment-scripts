resource "ibm_is_volume" "vol1" {
  name		= "${var.HOSTNAME}-vol1"
  zone		= var.ZONE
  profile	= var.VOL_PROFILE
  iops		= var.VOL_IOPS
  capacity	= var.VOL1
}

resource "ibm_is_volume" "vol2" {
  name		= "${var.HOSTNAME}-vol2"
  zone		= var.ZONE
  profile	= var.VOL_PROFILE
  iops		= var.VOL_IOPS
  capacity	= var.VOL2
}

resource "ibm_is_volume" "vol3" {
  name		= "${var.HOSTNAME}-vol3"
  zone		= var.ZONE
  profile	= var.VOL_PROFILE
  iops		= var.VOL_IOPS
  capacity	= var.VOL3
}

output "volumes_list" {
  value       = [ ibm_is_volume.vol1.id , ibm_is_volume.vol2.id , ibm_is_volume.vol3.id ]
}