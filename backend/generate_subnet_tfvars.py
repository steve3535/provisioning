import json
from subnets import get_ahv_subnets

def generate_subnet_tfvars():
    datacenters = {
        "dc1_subnets": "lu652",
        "dc3_subnets": "lu653"
    }
    all_subnets = {}
    for var_name, datacenter in datacenters.items():
        subnets = get_ahv_subnets(datacenter)
        all_subnets[var_name] = subnets

    with open('../terraform/lan_subnets.tfvars', 'w') as f:
        for var_name, subnets in all_subnets.items():
            f.write(f'{var_name} = ' + json.dumps(subnets, indent=2) + '\n\n')

if __name__ == "__main__":
    generate_subnet_tfvars()