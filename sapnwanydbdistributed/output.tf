output "DB-HOSTNAME" {
  value		= module.vsi-db.DB-HOSTNAME
}

output "DB-FLOATING-IP" {
  value		= module.vsi-db.DB-FLOATING-IP
}

output "DB-PRIVATE-IP" {
  value		= module.vsi-db.DB-PRIVATE-IP
}

output "APP-HOSTNAME" {
  value		= module.vsi-app.APP-HOSTNAME
}

output "APP-FLOATING-IP" {
  value		= module.vsi-app.APP-FLOATING-IP
}

output "APP-PRIVATE-IP" {
  value		= module.vsi-app.APP-PRIVATE-IP
}
