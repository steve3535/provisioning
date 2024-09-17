terraform {
  required_providers {
    nutanix = {
        source = "nutanix/nutanix"
        }
    vsphere = {
        source = "hashicorp/vsphere"
        }
  }
}

provider "nutanix" {
    username = var.nutanix_username
    password = var.nutanix_password 
    endpoint = var.prism_central_dc1
    insecure = true
    alias = "ahv-dc1"
  
}

provider "nutanix" {
    username = var.nutanix_username 
    password = var.nutanix_password
    endpoint = var.prism_central_dc3
    insecure = true
    alias = "ahv-dc3"
  
}

provider "vsphere" {
    user = var.vsphere_username
    password = var.vsphere_password
    vsphere_server = var.vsphere_server 
    allow_unverified_ssl = true 
    
}