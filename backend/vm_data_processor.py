import yaml

def process_vm_data(form_data):
    vm_data = form_data.to_dict()
    numeric_fields = ['cpu','mem','disk2_size']
    for field in numeric_fields:
        if field in vm_data:
            vm_data[field]=int(vm_data[field])

    structured_data = {
        vm_data['vm_name']:{
            'name': vm_data['vm_name'],
            'hostname': vm_data['hostname'],
            'domain': vm_data['domain'],
            'datacenter': vm_data['datacenter'],
            'cluster': vm_data['cluster'],
            'image': vm_data['image'],
            'storage': vm_data['storage'],
            'subnet': vm_data['subnet'],
            'cpu': vm_data['cpu'],            
            'mem': vm_data['mem'],
            'disk2_size_gb': vm_data['disk2_size_gb'],
            'ip': vm_data['ip'],
            'gateway': vm_data['gateway']
        }
    }

    yaml_data = yaml.dump(structured_data,default_flow_style=False)

    return yaml_data
