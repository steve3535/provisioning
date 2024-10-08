
      resource "nutanix_virtual_machine" "toto1" {
        name                 = "toto1"
        description          = ""
        cluster_uuid         = data.nutanix_cluster.dc3_clusters["lu651"].metadata.uuid 
        num_vcpus_per_socket = 2
        num_sockets          = 1
        memory_size_mib      = 4096

        disk_list {
          data_source_reference = {
            kind = "image"
            uuid = data.nutanix_image.dc3_images["rhel8-dc3"].metadata.uuid
          }
        }

        disk_list {
          disk_size_mib = 102400
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.lu651_storages["Nutanix_fs01_dr"]
            }
          }
        }

        nic_list {
          subnet_uuid = var.dc3_subnets["New_PROD 192.168.25.x"]
        }  
     }
    