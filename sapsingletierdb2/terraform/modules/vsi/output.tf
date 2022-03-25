output "HOSTNAME" {
  value		= ibm_is_instance.vsi.name
}

output "FLOATING-IP" {
  value		= ibm_is_floating_ip.fip.address
}

output "PRIVATE-IP" {
  value		= ibm_is_instance.vsi.primary_network_interface[0].primary_ipv4_address
}
