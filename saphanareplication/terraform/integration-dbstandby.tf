# Export Terraform variable values to an Ansible var_file
resource "local_file" "db_ansible_saphanastanby-vars" {
  //depends_on = [ module.dbstandby-vsi ]
  content = <<-DOC
---
#Ansible vars_file containing variable values passed from Terraform.
#Generated by "terraform plan&apply" command.

#HANA system configuration
hana_sid: "${var.hana_sid}"
hana_sysno: "${var.hana_sysno}"
hana_system_usage: "${var.hana_system_usage}"
hana_components: "${var.hana_components}"
sap_master_password: "${var.sap_master_password}"
db_host: "${module.db-vsi.PRIVATE-IP}"
db_hostname: "${var.DB-HOSTNAME}"
replication_mode: "${var.replication_mode}"
operation_mode: "${var.operation_mode}"

#SAP HANA Installation kit path
kit_saphana_file: "${var.kit_saphana_file}"
...
    DOC
  filename = "../ansible/saphanadbstandby-vars.yml"
}
