
output "APP-HOSTNAME" {
  value		= ibm_is_instance.vsi-app.name
}

output "APP-FLOATING-IP" {
  value		= ibm_is_floating_ip.fip.address
}

output "APP-PRIVATE-IP" {
  value		= ibm_is_instance.vsi-app.primary_network_interface[0].primary_ipv4_address
}
