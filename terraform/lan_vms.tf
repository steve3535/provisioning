
      resource "nutanix_virtual_machine" "test101" {
        name                 = "test101"
        description          = ""
        provider             = nutanix.dc1
        cluster_uuid         = data.nutanix_cluster.dc1_clusters["lu650"].metadata.uuid 
        num_vcpus_per_socket = 1
        num_sockets          = 1
        memory_size_mib      = 512

        disk_list {
          data_source_reference = {
            kind = "image"
            uuid = data.nutanix_image.dc1_images["rhel8-dc1"].metadata.uuid
          }
        }

        disk_list {
          disk_size_mib = 10240
          storage_config {
            storage_container_reference {
              kind = "storage_container"
              uuid = var.lu650_storages["NUT_AHV_DC1_RH_PGSQL"]
            }
          }
        }

        nic_list {
          subnet_uuid = var.dc1_subnets["Production"]
        }  
     }
    