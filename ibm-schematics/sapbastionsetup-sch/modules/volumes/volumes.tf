data "ibm_is_subnet" "subnet" {
  name		= var.SUBNET
}

resource "ibm_is_volume" "vol1" {
  name		= "${var.HOSTNAME}-vol1"
  zone		= var.ZONE
  profile	= var.VOL_PROFILE
  iops		= var.VOL_IOPS
  capacity	= var.VOL1
  depends_on	= [ data.ibm_is_subnet.subnet ]
}

output "volumes_list" {
  value       = [ ibm_is_volume.vol1.id ]
}
