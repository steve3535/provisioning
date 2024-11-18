terraform {
  required_providers {
    nutanix = {
        source = "nutanix/nutanix"
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

# data "nutanix_image" "dc1_images" {
#     for_each = local.dc1_images 
#     image_name = each.value.name 
#     provider = nutanix.dc1
# }

# data "nutanix_image" "dc3_images" {
#     for_each = local.dc3_images 
#     image_name = each.value.name  
#     provider = nutanix.dc3
# }
data "nutanix_image" "rhel8-dc1" {
  image_name = "RHEL8STD-latest"
  provider   = nutanix.dc1
}

data "nutanix_image" "rhel8-dc3" {
  image_name = "RHEL8STD-latest"
  provider   = nutanix.dc3
}


# ============= VMWARE ESX INFRA ================

# provider "vsphere" {
#     user = var.vsphere_username
#     password = var.vsphere_password
#     vsphere_server = var.vsphere_server 
#     allow_unverified_ssl = true     
#     client_debug = true 
# }

# data "vsphere_datacenter" "esx_dc" {
#   name = var.vsphere_datacenter
# }

# data "vsphere_compute_cluster" "esx_cluster" {
#   name = var.vsphere_cluster
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_resource_pool" "esx_pool" {
#   name = var.vsphere_resource_pool
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# # VMWARE CONTENT LIBRARY

# data "vsphere_content_library" "esx_lib1" {
#   name = "Linux_Templates_DC1"
# }

# data "vsphere_content_library" "esx_lib2" {
#   name = "Linux_Templates_DC2"
# }

# data "vsphere_content_library_item" "esx_lib1_item" {
#   name = "RHEL8STD-latest"
#   type = "ovf"
#   library_id = data.vsphere_content_library.esx_lib1.id
# }

# data "vsphere_content_library_item" "esx_lib2_item" {
#   name = "RHEL8STD-latest"
#   type = "ovf"
#   library_id = data.vsphere_content_library.esx_lib2.id
# }



# # ESX HOSTS

# data "vsphere_host" "nut-dmz-01" {
#   name = "nut-dmz-01.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-02" {
#   name = "nut-dmz-02.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-03" {
#   name = "nut-dmz-03.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-04" {
#   name = "nut-dmz-04.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-05" {
#   name = "nut-dmz-05.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-06" {
#   name = "nut-dmz-06.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-07" {
#   name = "nut-dmz-07.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-08" {
#   name = "nut-dmz-08.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-09" {
#   name = "nut-dmz-09.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }

# data "vsphere_host" "nut-dmz-10" {
#   name = "nut-dmz-10.lalux.local"
#   datacenter_id = data.vsphere_datacenter.esx_dc.id
# }
