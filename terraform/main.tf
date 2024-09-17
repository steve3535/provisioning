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

# provider "nutanix" {
#     username = var.nutanix_username
#     password = var.nutanix_password 
#     endpoint = var.prism_central_dc1
#     insecure = true
#     alias = "dc1"  
# }


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
  dc1_clusters = {for k, v in var.nutanix_clusters : k => v if v == "dc1"}
  dc3_clusters = {for k, v in var.nutanix_clusters : k => v if v == "dc3"}
  dc1_images = {for k,v in var.nutanix_images: k => v if v == "dc1"}
  dc3_images = {for k,v in var.nutanix_images: k => v if v == "dc3"}
  dc1_storages = {for k,v in var.nutanix_storages: k => v if var.nutanix_clusters[v] == "dc1"}
  dc3_storages = {for k,v in var.nutanix_storages: k => v if var.nutanix_clusters[v] == "dc3"}
}

data "nutanix_cluster" "dc1_clusters" {
  for_each = local.dc1_clusters
  name     = each.key
  provider = nutanix.dc1
}

data "nutanix_cluster" "dc3_clusters" {
  for_each = local.dc3_clusters
  name     = each.key
  provider = nutanix.dc3
}

data "nutanix_image" "dc1_images" {
    for_each = local.dc1_images 
    image_name = each.key 
    provider = nutanix.dc1
}

data "nutanix_image" "dc3_images" {
    for_each = local.dc3_images 
    image_name = each.key 
    provider = nutanix.dc3
}

data "nutanix_storage_container" "dc1_storage_containers" {
    for_each = local.dc1_storages
    name = each.key 
    cluster_uuid = data.nutanix_cluster.dc1_clusters[each.value].metadata.uuid
    provider = nutanix.dc1 
}

# ============= VMWARE ESX INFRA ================

provider "vsphere" {
    user = var.vsphere_username
    password = var.vsphere_password
    vsphere_server = var.vsphere_server 
    allow_unverified_ssl = true 
    
}

resource "nutanix_virtual_machine" "test" {
  name        = "test"
  description = "test"
  provider = nutanix.dc1
  cluster_uuid = data.nutanix_cluster.dc1_clusters["lu650"].metadata.uuid 
  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 2048

  disk_list {
    data_source_reference = {
      kind = "image"
      uuid = data.nutanix_image.dc1_images["rhel8-dc1"].metadata.uuid 
    }

    device_properties {
      disk_address = {
        device_index = 0
        adapter_type = "SCSI"
      }
      device_type = "DISK"
    }
  }

  disk_list {
    disk_size_mib = (50*1024)
    storage_config {
      storage_container_reference {
        kind = "storage_container"
        uuid = data.nutanix_storage_container.dc1_storage_containers["NUT_AHV_DC1_01"].storage_container_uuid
      }
    }
  }

}