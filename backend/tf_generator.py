def generate_lan_vm_config(vm_name, vm_specs):
    return f"""
      # Read the SSH public key
      data "local_file" "ssh_public_key" {{
        filename = "../keys/localadmin.pub"
      }}

      resource "nutanix_virtual_machine" "{vm_name}" {{
        name                 = "{vm_specs['name']}"
        description          = ""
        provider             = nutanix.{vm_specs['datacenter']}
        cluster_uuid         = data.nutanix_cluster.{vm_specs['datacenter']}_clusters["{vm_specs['cluster'].split('.')[0]}"].metadata.uuid 
        num_vcpus_per_socket = {vm_specs['cpu']}
        num_sockets          = 1
        memory_size_mib      = {vm_specs['mem']}
        boot_type            = "UEFI"

        disk_list {{
          data_source_reference = {{
            kind = "image"
            uuid = data.nutanix_image.{vm_specs['datacenter']}_images["{vm_specs['image']}"].metadata.uuid
          }}
          device_properties {{
            disk_address = {{
              device_index = 0
              adapter_type = "SCSI"
            }}
            device_type = "DISK"
          }}
        }}

        disk_list {{
          disk_size_mib = {int(vm_specs['disk2_size_gb']) * 1024}
          storage_config {{
            storage_container_reference {{
              kind = "storage_container"
              uuid = var.{vm_specs['cluster'].split('.')[0]}_storages["{vm_specs['storage']}"]
            }}
          }}
        }}

        guest_customization_cloud_init_user_data = base64encode(templatefile("user-data.yaml", {{
          vm_hostname = "{vm_specs['hostname']}",
          vm_ip = "{vm_specs['ip']}",
          vm_prefix = "24",
          vm_gateway = "{vm_specs['gateway']}",
          vm_dns1 = "200.1.1.218",
          vm_dns2 = "200.1.1.163",
          ssh_pub_key = data.local_file.ssh_public_key.content
        }}))

        nic_list {{
          subnet_uuid = var.{vm_specs['datacenter']}_subnets["{vm_specs['subnet']}"]
        }}
      }}
    """