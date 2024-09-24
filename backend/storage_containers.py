import os
import requests
from dotenv import load_dotenv

def get_storages(cluster):
    load_dotenv()
    username = os.getenv('NUTANIX_USERNAME')
    password = os.getenv('NUTANIX_PASSWORD')
    
    try:
        url = f"https://{cluster}:9440/PrismGateway/services/rest/v2.0/storage_containers"
        response = requests.get(url, auth=(username, password), verify=False)  # TODO: Fix SSL verification
        response.raise_for_status()
        storage_containers = response.json().get('entities', [])
        
        return {
            storage['name']: storage['storage_container_uuid']
            for storage in storage_containers
        }
    except Exception as e:
        print(f"Error fetching storage containers from {cluster}: {e}")
        return {}