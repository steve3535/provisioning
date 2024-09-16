import yaml 
from cerberus import Validator 

import yaml  # This is correct, PyYAML is imported as 'yaml'
from cerberus import Validator

# Define the schema
schema = {
    'vm_definitions': {
        'type': 'dict',
        'schema': {
            'lan_vms': {
                'type': 'list',
                'schema': {
                    'type': 'dict',
                    'schema': {
                        'vm_nickname': {'type': 'string'},
                        'vm_name': {'type': 'string'},
                        'descr': {'type': 'string'},
                        'hostname': {'type': 'string'},
                        'datacenter': {'type': 'string'},
                        'cluster': {'type': 'string'},
                        'image': {'type': 'string'},
                        'subnet': {'type': 'string'},
                        'storage': {'type': 'string'},
                        'mem': {'type': 'integer'},
                        'cpu': {'type': 'integer'},
                        'cpu_socket': {'type': 'integer'},
                        'disk2_size_gb': {'type': 'integer'},
                        'ip': {'type': 'string', 'regex': '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$'},
                        'net_prefix': {'type': 'integer', 'min': 0, 'max': 32},
                        'gw': {'type': 'string', 'regex': '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$'},
                        'satellite_env': {'type': 'string'}
                    }
                }
            },
            'dmz_vms': {
                'type': 'list',
                'schema': {
                    'type': 'dict',
                    'schema': {
                        'vm_nickname': {'type': 'string'},
                        'vm_name': {'type': 'string'},
                        'descr': {'type': 'string'},
                        'hostname': {'type': 'string'},
                        'datacenter': {'type': 'string'},
                        'content_library_item': {'type': 'string'},
                        'host': {'type': 'string'},
                        'network': {'type': 'string'},
                        'datastore': {'type': 'string'},
                        'folder': {'type': 'string'},
                        'mem': {'type': 'integer'},
                        'cpu': {'type': 'integer'},
                        'cpu_socket': {'type': 'integer'},
                        'disk2_size_gb': {'type': 'integer'},
                        'ip': {'type': 'string', 'regex': '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$'},
                        'net_prefix': {'type': 'integer', 'min': 0, 'max': 32},
                        'gw': {'type': 'string', 'regex': '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$'},
                        'subnet': {'type': 'string', 'regex': '^(?:[0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}$'},
                        'user': {'type': 'string'},
                        'resource_pool': {'type': 'string'},
                        'satellite_env': {'type': 'string'}
                    }
                }
            }
        }
    }
}

def validate_yaml(file_path):
    with open(file_path, 'r') as file:
        try:
            data = yaml.safe_load(file)
        except yaml.YAMLError as e:
            print(f"Error parsing YAML file: {e}")
            return False

    v = Validator(schema)
    if v.validate(data):
        print("YAML file is valid.")
        return True
    else:
        print("YAML file is invalid. Errors:")
        for field, errors in v.errors.items():
            print(f"{field}: {errors}")
        return False

# Usage
if __name__ == "__main__":
    validate_yaml('vm_definitions.yaml')