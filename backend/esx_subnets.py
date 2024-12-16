from pyVmomi import vim
from esx_utils import connect_to_vcenter, disconnect_from_vcenter
import os

blacklist = [
    "DMZ_DKV_MAIL",
    "DMZ_EXT_LALUX_IRONPORT",
    "DMZ_PRO_ExprWay_EXT",
    "DMZ_PRO_ExprWay_INT",
    "DVS_DMZ_EXT-DVUplinks-341272",
    "PRO_SCAN_ANTIVIRUS_EXT",
    "REC_SCAN_ANTIVIRUS_EXT",
    "DMZ_LAN_Extension",
    "DMZ_MGMT_ESX",
    "DMZ_TST_API_GW",
    "DMZ_TST_API_MGMT",
    "DVS_DMZ_INT-DVUplinks-341274"
]

def get_esx_networks(si, esx_host):
    try:
        content = si.RetrieveContent()
        container = content.viewManager.CreateContainerView(content.rootFolder, [vim.HostSystem], True)
        esx = next((host for host in container.view if host.name == esx_host), None)
        
        if not esx:
            raise ValueError(f"ESXi host '{esx_host}' not found")
        
        return [network.name for network in esx.network]
    except Exception as e:
        print(f"Error fetching ESX networks: {e}")
        return []

def generate_terraform_datasources(networks, filename):
    with open(filename, 'w') as f:
        f.write('# This file is generated automatically. DO NOT EDIT MANUALLY.\n\n')
        f.write('###############################\n')
        f.write('# ESX NETWORKS\n')
        f.write('###############################\n\n')
        
        for network in networks:
            if network in ["Backplane Network","CVM Backplane Network","VM Network"]:
                continue
            if network in blacklist:
                continue
            resource_name = network.replace('-', '_').replace('.', '_')            
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
            print(f"- {network}")
        
        # Generate Terraform data sources file
        tf_file = '../terraform/esx_networks.tf'
        generate_terraform_datasources(networks, tf_file)
        print(f"\nTerraform data sources file '{tf_file}' has been generated.")

    finally:
        disconnect_from_vcenter(si)

if __name__ == "__main__":
    main()