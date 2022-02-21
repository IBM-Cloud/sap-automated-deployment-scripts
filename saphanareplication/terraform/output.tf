output "DB-HOSTNAME" {
  value		= module.db-vsi.HOSTNAME
}

output "DB-FLOATING-IP" {
  value		= module.db-vsi.FLOATING-IP
}

output "DB-PRIVATE-IP" {
  value		= module.db-vsi.PRIVATE-IP
}

output "DBSTANDBY-HOSTNAME" {
  value		= module.dbstandby-vsi.HOSTNAME
}

output "DBSTANDBY-FLOATING-IP" {
  value		= module.dbstandby-vsi.FLOATING-IP
}

output "DBSTANDBY-PRIVATE-IP" {
  value		= module.dbstandby-vsi.PRIVATE-IP
}
