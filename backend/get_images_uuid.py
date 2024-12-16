import requests
import json
from base64 import b64encode
import os
from dotenv import load_dotenv

def get_image_uuid(pc, image_name):
    load_dotenv()
    username = os.getenv('NUTANIX_USERNAME')
    password = os.getenv('NUTANIX_PASSWORD')
    credentials = b64encode(f"{username}:{password}".encode()).decode()
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Basic {credentials}",
    }
    
    payload = {
        "kind": "image",
        "length": 50
    }
    
    url = f"https://{pc}:9440/api/nutanix/v3/images/list"
    response = requests.post(url, headers=headers, json=payload, verify=False)
    response.raise_for_status()
    if response.status_code == 200:
        images = response.json().get('entities', [])
        if images:
            return images[0]['metadata']['uuid']
    return None

# Get UUIDs for both datacenters
dc1_uuid = get_image_uuid("lu652.lalux.local", "RHEL8STD-latest")
dc3_uuid = get_image_uuid("lu653.lalux.local", "RHEL8STD-latest")

print(f"DC1 Image UUID: {dc1_uuid}")
print(f"DC3 Image UUID: {dc3_uuid}")