import os
import json
import http.client
from base64 import b64encode
from dotenv import load_dotenv

def basic_auth():
    load_dotenv()
    username = os.getenv('NUTANIX_USERNAME')
    password = os.getenv('NUTANIX_PASSWORD')
    return b64encode(f"{username}:{password}".encode()).decode()

def get_ahv_subnets(pc):    
    conn = http.client.HTTPSConnection(pc, 9440)
    credentials = basic_auth()
    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Basic {credentials}",
        "Accept": "application/json"
    }
    payload = json.dumps({
        "kind": "subnet",
        "offset": 0,
        "length": 100
    })
    try:
        conn.request("POST", "/api/nutanix/v3/subnets/list", payload, headers)
        response = conn.getresponse()
        data = response.read()
        json_data = json.loads(data)
        subnets = json_data['entities']
        return {
            subnet['status']['name']: subnet['metadata']['uuid']
            for subnet in subnets
        }
    except Exception as e:
        print(f"Error fetching subnets from {pc}: {e}")
        return {}
    finally:
        conn.close()