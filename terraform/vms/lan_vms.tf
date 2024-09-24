
      resource "nutanix_virtual_machine" "toto3" {
        name                 = "toto3"
        description          = ""
        cluster_uuid         = data.nutanix_cluster.dc3_clusters["lu651"].metadata.uuid 
        num_vcpus_per_socket = 1
        num_sockets          = 1
        memory_size_mib      = 1024

        disk_list {
          data_source_reference = {
            kind = "image"
            uuid = data.nutanix_image.dc3_images["rhel8-dc3"].metadata.uuid
          }
        }

        disk_list {
          disk_size_mib = 10240
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.lu651_storages["NUT_AHV_DC3_VIE"]
            }
          }
        }

        nic_list {
          subnet_uuid = var.dc3_subnets["VLAN-128-Server"]
        }  
     }
    