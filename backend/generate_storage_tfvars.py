import json
from storage_containers import get_storages 

def generate_storage_tfvars():
    clusters = {
        "lu650_storages": "lu650",
        "lu651_storages": "lu651"
    }

    all_storages = {}

    for var_name, cluster in clusters.items():
        storages = get_storages(cluster)
        all_storages[var_name] = storages

    with open('../terraform/storage_containers.tfvars', 'w') as f:
        for var_name, storages in all_storages.items():
            f.write(f'{var_name} = ' + json.dumps(storages, indent=2) + '\n\n')

if __name__ == "__main__":
    generate_storage_tfvars()