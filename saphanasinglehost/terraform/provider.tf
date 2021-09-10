variable "ibmcloud_api_key" {
	description	= "IBM Cloud API key"
	sensitive	= true
		validation {
			condition     = length(var.ibmcloud_api_key) > 43 #&& substr(var.ibmcloud_api_key, 14, 15) == "-"
			error_message = "The ibmcloud_api_key value must be a valid IBM Cloud API key."
		}
}

provider "ibm" {
    ibmcloud_api_key	= var.ibmcloud_api_key
    region				= var.REGION
}
