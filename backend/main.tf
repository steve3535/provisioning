
resource "vsphere_virtual_machine" "test" {
  name             = "test"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.NUT_DMZ_INT_DC2_01.id
  num_cpus         = 1
  memory           = 2048
  guest_id         = "rhel8_64Guest"
  folder           = "your_vm_folder"

  network_interface {
    network_id = data.vsphere_network.REC_ESIGN_INT.id
  }

  disk {
    label = "disk0"
    size  = 50
  }

  disk {
    label = "disk1"
    size  = 100
    unit_number = 1
  }

  clone {
    template_uuid = data.vsphere_content_library_item.esx_lib1_item.id

    customize {
      linux_options {
        host_name = "test"
        domain    = "example.com"
      }

      network_interface {
        ipv4_address = "10.10.1.2"
        ipv4_netmask = 24
      }

      ipv4_gateway = "10.10.1.1"
    }
  }
}
