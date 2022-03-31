resource "ibm_is_volume" "vol" {

count = length( var.VOLUME_SIZES )
  name		= "${var.HOSTNAME}-vol${count.index}"
  zone		= var.ZONE
  capacity	= var.VOLUME_SIZES[count.index]
  profile	= var.VOL_PROFILE
  iops		= var.VOL_IOPS
}
