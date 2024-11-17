from pyVmomi import vim
from esx_utils import connect_to_vcenter, disconnect_from_vcenter
import os
import hashlib

def get_esx_networks(si, esx_host):
    try:
        content = si.RetrieveContent()
        container = content.viewManager.CreateContainerView(content.rootFolder, [vim.HostSystem], True)
        esx = next((host for host in container.view if host.name == esx_host), None)
        
        if not esx:
            raise ValueError(f"ESXi host '{esx_host}' not found")
        
        networks = []
        for network in esx.network:
            vlan_id = None
            if hasattr(network, 'portKeys') :
                port_dvs = network.config.distributedVirtualSwitch
                print(port_dvs)
            networks.append((network.name))
        
        return networks
    except Exception as e:
        print(f"Error fetching ESX networks: {e}")
        return []

def generate_terraform_datasources(networks, filename):
    with open(filename, 'w') as f:
        f.write('# This file is generated automatically. DO NOT EDIT MANUALLY.\n\n')
        f.write('###############################\n')
        f.write('# ESX NETWORKS\n')
        f.write('###############################\n\n')
        
        used_names = set()
        for network, vlan_id in networks:
            resource_name = network.replace('-', '_').replace('.', '_')
            if resource_name in used_names:
                if vlan_id is not None:
                    resource_name += f"_vlan_{vlan_id}"
                else:
                    resource_name += f"_{hashlib.md5(network.encode()).hexdigest()[:8]}"
            used_names.add(resource_name)
            
            f.write(f'data "vsphere_network" "{resource_name}" {{\n')
            f.write(f'  name          = "{network}"\n')
            f.write('  datacenter_id = data.vsphere_datacenter.esx_dc.id\n')
            f.write('}\n\n')

def main():
    si = connect_to_vcenter()
    if not si:
        return

    try:
        esx_host = os.getenv('ESX_HOST', 'nut-dmz-01.lalux.local')
        networks = get_esx_networks(si, esx_host)
        
        # Print networks
        print(f"Networks available on {esx_host}:")
        for network in networks:
            print(f"- {network}" )
        
        # Generate Terraform data sources file
        tf_file = '../terraform/esx_networks.tf'
        generate_terraform_datasources(networks, tf_file)
        print(f"\nTerraform data sources file '{tf_file}' has been generated.")

    finally:
        disconnect_from_vcenter(si)

if __name__ == "__main__":
    main()