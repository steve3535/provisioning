from pyVmomi import vim
from esx_utils import connect_to_vcenter, disconnect_from_vcenter

def get_esx_datastores(si):
    try:
        content = si.RetrieveContent()
        datastore_view = content.viewManager.CreateContainerView(content.rootFolder, [vim.Datastore], True)
        datastores = datastore_view.view
        
        return [datastore.name for datastore in datastores]
    except Exception as e:
        print(f"Error fetching ESX datastores: {e}")
        return []

def generate_terraform_datasources(datastores, filename):
    with open(filename, 'w') as f:
        f.write('# This file is generated automatically. DO NOT EDIT MANUALLY.\n\n')
        f.write('###############################\n')
        f.write('# ESX DATASTORES\n')
        f.write('###############################\n\n')
        
        for datastore in datastores:
            resource_name = datastore.replace('-', '_').replace('.', '_')
            f.write(f'data "vsphere_datastore" "{resource_name}" {{\n')
            f.write(f'  name          = "{datastore}"\n')
            f.write('  datacenter_id = data.vsphere_datacenter.esx_dc.id\n')
            f.write('}\n\n')

def main():
    si = connect_to_vcenter()
    if not si:
        return

    try:
        datastores = get_esx_datastores(si)
        
        # Print datastores
        print("ESX Datastores:")
        for datastore in datastores:
            print(f"- {datastore}")
        
        # Generate Terraform data sources file
        tf_file = '../terraform/esx_datastores.tf'
        generate_terraform_datasources(datastores, tf_file)
        print(f"\nTerraform data sources file '{tf_file}' has been generated.")

    finally:
        disconnect_from_vcenter(si)

if __name__ == "__main__":
    main()