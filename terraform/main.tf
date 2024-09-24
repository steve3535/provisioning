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

# ========== NUTANIX INFRA ==================

locals {
  nutanix_providers = {
    for k,v in var.nutanix_endpoints: k => {
        username = var.nutanix_username
        password = var.nutanix_password
        endpoint = v
        insecure = true 
    }
  }
}

provider "nutanix" {    
    username = var.nutanix_username
    password = var.nutanix_password
    endpoint = var.nutanix_endpoints["dc1"]
    insecure = true  
    alias = "dc1"
}

provider "nutanix" {    
    username = var.nutanix_username
    password = var.nutanix_password
    endpoint = var.nutanix_endpoints["dc3"]
    insecure = true  
    alias = "dc3"
}

locals {
  dc1_clusters = {for k, v in var.nutanix_clusters : k => v if v.dc == "dc1"}
  dc3_clusters = {for k, v in var.nutanix_clusters : k => v if v.dc == "dc3"}
  dc1_images = {for k,v in var.nutanix_images: k => v if v.dc == "dc1"}
  dc3_images = {for k,v in var.nutanix_images: k => v if v.dc == "dc3"}  
}


data "nutanix_cluster" "dc1_clusters" {
  for_each = local.dc1_clusters
  name     = each.value.name
  provider = nutanix.dc1
}

data "nutanix_cluster" "dc3_clusters" {
  for_each = local.dc3_clusters
  name     = each.value.name 
  provider = nutanix.dc3
}

data "nutanix_image" "dc1_images" {
    for_each = local.dc1_images 
    image_name = each.value.name 
    provider = nutanix.dc1
}

data "nutanix_image" "dc3_images" {
    for_each = local.dc3_images 
    image_name = each.value.name  
    provider = nutanix.dc3
}

# ============= VMWARE ESX INFRA ================

provider "vsphere" {
    user = var.vsphere_username
    password = var.vsphere_password
    vsphere_server = var.vsphere_server 
    allow_unverified_ssl = true 
    
}
