import yaml

def generate_terraform_config(yaml_data):
    vm_data = yaml.safe_load(yaml_data)
    
    terraform_config = ""
    
    for vm_name, vm_specs in vm_data.items():
        if vm_specs['domain'] == 'LAN':
            terraform_config += generate_lan_vm_config(vm_name, vm_specs)
        else:
            terraform_config += generate_dmz_vm_config(vm_name, vm_specs)
    
    return terraform_config

def generate_lan_vm_config(vm_name, vm_specs):
    return f"""
resource "nutanix_virtual_machine" "{vm_name}" {{
  name                 = "{vm_specs['name']}"
  cluster_name         = "{vm_specs['cluster']}"
  num_vcpus_per_socket = {vm_specs['cpu']}
  num_sockets          = 1
  memory_size_mib      = {vm_specs['mem']}

  disk_list {{
    data_source_reference = {{
      kind = "image"
      name = "{vm_specs['image']}"
    }}
  }}

  disk_list {{
    disk_size_mib = {int(vm_specs['disk2_size_gb']) * 1024}
  }}

  nic_list {{
    subnet_name = "{vm_specs['subnet']}"
  }}

  guest_customization_cloud_init_user_data = base64encode(<<-EOF
    #cloud-config
    hostname: {vm_specs['hostname']}
    fqdn: {vm_specs['hostname']}.example.com
    manage_etc_hosts: true
    users:
      - name: adminuser
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups: users, admin
        home: /home/adminuser
        shell: /bin/bash
        lock_passwd: false
    ssh_pwauth: true
    disable_root: false
    chpasswd:
      list: |
        adminuser:password
      expire: false
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl start qemu-guest-agent
      - systemctl enable qemu-guest-agent
  EOF
  )
}}
"""

def generate_dmz_vm_config(vm_name, vm_specs):
    return f"""
resource "vsphere_virtual_machine" "{vm_name}" {{
  name             = "{vm_specs['name']}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.{vm_specs['storage']}.id
  num_cpus         = {vm_specs['cpu']}
  memory           = {vm_specs['mem']}
  guest_id         = "rhel8_64Guest"
  folder           = "your_vm_folder"

  network_interface {{
    network_id = data.vsphere_network.{vm_specs['subnet']}.id
  }}

  disk {{
    label = "disk0"
    size  = 50
  }}

  disk {{
    label = "disk1"
    size  = {vm_specs['disk2_size_gb']}
    unit_number = 1
  }}

  clone {{
    template_uuid = data.vsphere_content_library_item.{vm_specs['image']}.id

    customize {{
      linux_options {{
        host_name = "{vm_specs['hostname']}"
        domain    = "example.com"
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

# This function would be called after processing the form data
def create_terraform_file(yaml_data):
    try:
      terraform_config = generate_terraform_config(yaml_data)
      with open('main.tf', 'w') as f:
          f.write(terraform_config)
      #return "Terraform configuration file created successfully"
      return terraform_config
    except Exception as e:
      return f"An error happened: {e}"