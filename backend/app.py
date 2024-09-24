from flask import Flask, render_template, request, jsonify 
import requests 
import json 
import yaml
import os,ssl
from base64 import b64encode
from dotenv import load_dotenv
import http.client 
from pyVim import connect #needed to call ESX apis
from pyVmomi import vim  #needed to call ESX apis 
from tf_generator import create_terraform_file
from vm_data_processor import process_vm_data
from dotenv import load_dotenv 

load_dotenv()

GITLAB_URL = os.environ.get('GITLAB_URL')
GITLAB_TOKEN = os.environ.get('GITLAB_TOKEN')
GITLAB_PROJECT_ID = os.environ.get('GITLAB_PROJECT_ID')

app = Flask(__name__)

def gitlab_trigger_pipeline(tf_content):
    url=f"{GITLAB_URL}/api/v4/projects/{GITLAB_PROJECT_ID}/trigger/pipeline"

    data={
        "token": f"{GITLAB_TOKEN}",        
        "ref": "main",
        "variables[TERRAFORM_CONTENT]": tf_content
    }

    try:
      response=requests.post(url,data)
      response.raise_for_status()
      return response.json()
    except Exception as e:
      print(f"Error while triggering pipeline, {str(e)}")
      print(f"Status: {e.response.status_code}")
      print(f"Response Content: {e.response.text if response else 'No content'}")

def basic_auth():
    load_dotenv()  # apparently, even if .env is in the upper folders, this will work 
    username = os.getenv('NUTANIX_USERNAME')
    password = os.getenv('NUTANIX_PASSWORD')
    credentials = b64encode(f"{username}:{password}".encode()).decode() #because b64encode expects a byte formatted string but we also need to return a byte free b64 hash
    return credentials

def get_domains():
    return ['LAN','DMZ']

def get_datacenters(domain):
    if domain == "LAN":
        return ['dc1','dc3']
    else:
        return ['NUT-DMZ-DC01','NUT-DMZ-DC02']

def get_ahv_pc(datacenter):
    return {"dc1":"lu652.lalux.local","dc3":"lu653.lalux.local"}[datacenter]

def get_esx_vcenter():
    return "lu309.lalux.local"
def get_images(datacenter):
    images = {
        'dc1': ['rhel8-dc1'],
        'dc3': ['rhel8-dc3'],
        'NUT-DMZ-DC01': ['esx_lib1_item'],
        'NUT-DMZ-DC02': ['esx_lib2_item']        
    }

    return images.get(datacenter,[])

def get_clusters(datacenter):
    clusters = {
        'dc1': ['lu650.lalux.local'],
        'dc3': ['lu651.lalux.local'],
        'NUT-DMZ-DC01': ['nut-dmz-01','nut-dmz-03','nut-dmz-05','nut-dmz-07','nut-dmz-09'],
        'NUT-DMZ-DC02': ['nut-dmz-02','nut-dmz-04','nut-dmz-06','nut-dmz-08','nut-dmz-10']
    }

    return clusters.get(datacenter,[])

def get_ahv_subnets(datacenter):
    pc = get_ahv_pc(datacenter)
    conn = http.client.HTTPSConnection(pc,9440) #cool http.client supports natively and more simply https, beware this is just the creation of the connection object, not an actual connection 
    credentials = basic_auth()
    headers = {
        "Content-Type": "Application/json",
        "Authorization": f"Basic {credentials}",
        "Accept": "Application/json"
    }
    #important to turn python dict to true json here
    payload = json.dumps({
        "kind": "subnet",
        "offset": 0,
        "length": 100
    })
    try:
      conn.request("POST","/api/nutanix/v3/subnets/list",payload,headers=headers)
    except Exception as e:
      print(f"An error occured during the connection request: {e}")
    
    response = conn.getresponse()  # response object 
    data = response.read() #raw json data 
    json_data = json.loads(data)
    subnets = json_data['entities']

    subnets_names = [ subnet['status']['name'] for subnet in subnets ]

    return subnets_names

def get_esx_subnets():
    load_dotenv()
    username=os.getenv('ESX_USERNAME') #!!! CHANGE CREDENTIALS TO A PRIVILEGED ESX SA !!!
    password=os.getenv('ESX_PASSWORD')
    # set to the first ESX host since networks in vsphere are created across all hosts (unless exception)
    esx_host = "nut-dmz-01.lalux.local"
    vcenter = get_esx_vcenter()

    try:
        context = ssl.create_default_context()
        context.check_hostname = False 
        context.verify_mode = ssl.CERT_NONE 
        
        si = connect.SmartConnect(
            host=vcenter,
            user=username,
            pwd=password,
            sslContext=context
        )
        
    except Exception as e:
        print(f"An error occured during the connection request: {e}")

    content = si.RetrieveContent()
    network_view = content.viewManager.CreateContainerView(content.rootFolder, [vim.Network], True)
    networks = network_view.view

    subnet_names = [network.name for network in networks if isinstance(network, vim.Network)]

    connect.Disconnect(si)
    return subnet_names 


def get_ahv_storages(cluster):
    #couldnt get this to work with http.client -- open a support case
    load_dotenv()
    username = os.getenv('NUTANIX_USERNAME')
    password=os.getenv('NUTANIX_PASSWORD')
    try:
      url=f"https://{cluster}:9440/PrismGateway/services/rest/v2.0/storage_containers"
      response = requests.get(url,auth=(username,password),verify=False) #plan to fix SSL error
      response.raise_for_status() # do we need this ?
      storage_containers = response.json().get('entities')   
      print(len(storage_containers))  
    except Exception as e:
        print(e)
    return [ storage['name'] for storage in storage_containers]


def get_esx_datastores():
    load_dotenv()
    username = os.getenv('ESX_USERNAME')
    password = os.getenv('ESX_PASSWORD')
    vcenter = get_esx_vcenter()

    try:
        context = ssl.create_default_context()
        context.check_hostname = False 
        context.verify_mode = ssl.CERT_NONE 
        
        si = connect.SmartConnect(
            host=vcenter,
            user=username,
            pwd=password,
            sslContext=context
        )
        
        content = si.RetrieveContent()
        datastore_view = content.viewManager.CreateContainerView(content.rootFolder, [vim.Datastore], True)
        datastores = datastore_view.view

        datastore_names = [datastore.name for datastore in datastores]

        connect.Disconnect(si)
        return datastore_names
    
    except Exception as e:
        print(f"An error occurred while retrieving ESX datastores: {e}")
        return []

@app.route('/')
def index():
    return render_template('index.html',domains=get_domains())

@app.route('/get_datacenters')
def datacenters():
    domain = request.args.get('domain')
    return jsonify(get_datacenters(domain))

@app.route('/get_clusters')
def clusters():
    datacenter = request.args.get('datacenter')
    return jsonify(get_clusters(datacenter))

@app.route('/get_images')
def images():
    datacenter = request.args.get('datacenter')    
    return jsonify(get_images(datacenter))

@app.route('/get_subnets')
def subnets():
    datacenter = request.args.get('datacenter')
    if "DMZ" in datacenter:
      return jsonify(get_esx_subnets())
    else:
      return jsonify(get_ahv_subnets(datacenter))

@app.route('/get_storages')
def storages():
    cluster = request.args.get('cluster')
    print(cluster)
    if 'dmz' in cluster:
        return jsonify(get_esx_datastores())
    else:
        return jsonify(get_ahv_storages(cluster))


@app.route('/submit', methods=["POST"])
def submit():
    try:
      yaml_data = process_vm_data(request.form)
      #result = create_terraform_file(yaml_data)
      result = create_terraform_file(yaml_data)
      pipeline_response = gitlab_trigger_pipeline(result)

      print(pipeline_response)


      return jsonify({"pipeline_id": pipeline_response.get('id'),
                      "pipeline_url": pipeline_response.get('web_url'),
                      #"terraform_content": result
                      }),200
    except Exception as e:
        app.logger.error(f"{e}")
        return jsonify({"FATAL": f"An error occured while processing your request {e}"}),500    
  
if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True,port=5500)
