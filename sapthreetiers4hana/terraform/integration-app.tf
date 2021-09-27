# Export Terraform variable values to an Ansible var_file
resource "local_file" "app_ansible_saps4app-vars" {
  depends_on = [ module.db-vsi ]
  content = <<-DOC
---
#Ansible vars_file containing variable values passed from Terraform.
#Generated by "terraform plan&apply" command.

#SAP system configuration
sap_sid: "${var.sap_sid}"
sap_ascs_instance_number: "${var.sap_ascs_instance_number}"
sap_ci_instance_number: "${var.sap_ci_instance_number}"
sap_master_password: "${var.sap_master_password}"

#HANA config
hdb_host: "${module.db-vsi.PRIVATE-IP}"
hdb_sid: "${var.hana_sid}"
hdb_instance_number: "${var.hana_sysno}"
hdb_master_password: "${var.hana_master_password}"
# Number of concurrent jobs used to load and/or extract archives to HANA Host
hdb_concurrent_jobs: "${var.hdb_concurrent_jobs}"

#SAP S4HANA APP Installation kit path
kit_sapcar_file: "${var.kit_sapcar_file}"
kit_swpm_file: "${var.kit_swpm_file}"
kit_sapexe_file: "${var.kit_sapexe_file}"
kit_sapexedb_file: "${var.kit_sapexedb_file}"
kit_igsexe_file: "${var.kit_igsexe_file}"
kit_igshelper_file: "${var.kit_igshelper_file}"
kit_saphotagent_file: "${var.kit_saphotagent_file}"
kit_hdbclient_file: "${var.kit_hdbclient_file}"
kit_s4hana_export: "${var.kit_s4hana_export}"
...
    DOC
  filename = "../ansible/saps4app-vars.yml"
}
