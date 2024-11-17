import yaml

def generate_terraform_config(yaml_data):
    vm_data = yaml.safe_load(yaml_data)
    
    terraform_lan_config = ""
    terraform_dmz_config = ""
    
    for vm_name, vm_specs in vm_data.items():
        if vm_specs['domain'] == 'LAN':
            terraform_lan_config += generate_lan_vm_config(vm_name, vm_specs)
        else:
            terraform_dmz_config += generate_dmz_vm_config(vm_name, vm_specs)
    
    return terraform_lan_config,terraform_dmz_config 

def generate_lan_vm_config(vm_name, vm_specs):
    return f"""
      resource "nutanix_virtual_machine" "{vm_name}" {{
        name                 = "{vm_specs['name']}"
        description          = ""
        provider             = nutanix.{vm_specs['datacenter']}
        cluster_uuid         = data.nutanix_cluster.{vm_specs['datacenter']}_clusters["{vm_specs['cluster'].split('.')[0]}"].metadata.uuid 
        num_vcpus_per_socket = {vm_specs['cpu']}
        num_sockets          = 1
        memory_size_mib      = {vm_specs['mem']}

        disk_list {{
          data_source_reference = {{
            kind = "image"
            uuid = data.nutanix_image.{vm_specs['datacenter']}_images["{vm_specs['image']}"].metadata.uuid
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

        nic_list {{
          subnet_uuid = var.{vm_specs['datacenter']}_subnets["{vm_specs['subnet']}"]
        }}  
     }}
    """

def generate_dmz_vm_config(vm_name, vm_specs):
  try:
    return f"""
      resource "vsphere_virtual_machine" "{vm_name}" {{  
        name             = "{vm_specs['name']}"
        resource_pool_id = data.vsphere_resource_pool.esx_pool.id 
        host_system_id   = data.vsphere_host.{vm_specs['cluster']}.id
        datastore_id     = data.vsphere_datastore.{vm_specs['storage']}.id
        firmware         = "efi"
        num_cpus         = {vm_specs['cpu']}
        memory           = {vm_specs['mem']}
        guest_id         = "rhel8_64Guest"
        folder           = "/DMZ"
        wait_for_guest_net_timeout = 10

        network_interface {{
          network_id = data.vsphere_network.{vm_specs['subnet']}.id
        }}
      
        disk {{
          label = "disk0"
          size  = 50
          controller_type = "scsi"
        }}
      
        disk {{
          label = "disk1"
          size  = {vm_specs['disk2_size_gb']}
          controller_type = "scsi"
          unit_number = 1
        }}
      
        clone {{
          template_uuid = data.vsphere_content_library_item.{vm_specs['image']}.id
      
          customize {{
            linux_options {{
              host_name = "{vm_specs['name']}"
              domain    = "lalux.local"
            }}
      
            network_interface {{
              ipv4_address = "{vm_specs['ip']}"
              ipv4_netmask = 24
            }}
      
            ipv4_gateway = "{vm_specs['gateway']}"
          }}
        }}
      }}
    """
  except Exception as e:
    print(f"An error occured while generating DMZ VM tf config: {e}")

# This function would be called after processing the form data
def create_terraform_file(yaml_data):
    try:
      terraform_lan_config,terraform_dmz_config = generate_terraform_config(yaml_data)
      #>>>> return the content rather than writing to a local file because we need to ship this onto gitlab 
      # with open('../terraform/lan_vms.tf', 'w') as f:
      #     f.write(terraform_lan_config)
      # with open('../terraform/dmz_vms.tf', 'w') as f:
      #     f.write(terraform_dmz_config)
      if terraform_lan_config:
        return terraform_lan_config
      else:
        return ""
      #return "Terraform configuration files created successfully"
      
    except Exception as e:
      return f"An error happened while creating vm definition files: {e}"