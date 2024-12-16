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
SSH_PUB_KEY = os.environ['LOCALADMIN_SSH_PUB_KEY']

app = Flask(__name__)

def gitlab_trigger_pipeline(tf_content,user_data):
    url=f"{GITLAB_URL}/api/v4/projects/{GITLAB_PROJECT_ID}/trigger/pipeline"

    # Read necessary Terraform files
    with open('../terraform/main.tf', 'r') as f:
        main_tf = f.read()
    with open('../terraform/variables.tf', 'r') as f:
        vars_tf = f.read()
    with open('../terraform/lan_subnets.tfvars', 'r') as f:
        subnets_tfvars = f.read()
    with open('../terraform/storage_containers.tfvars', 'r') as f:
        storage_tfvars = f.read()

    data = {
        "token": f"{GITLAB_TOKEN}",        
        "ref": "v2",
        "variables[TERRAFORM_CONTENT]": tf_content,
        "variables[USER_DATA]": user_data,
        "variables[TF_MAIN]": main_tf,
        "variables[TF_VARS]": vars_tf,
        "variables[TF_VARS_LAN_SUBNETS]": subnets_tfvars,
        "variables[TF_VARS_STORAGE]": storage_tfvars
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
    return ['NUTANIX']

def get_environment():
    return ['DEV_TEST', 'RECETTE_PREPROD', 'PROD']

def get_datacenters(domain):
    if domain == "NUTANIX":
        return ['dc1','dc3','NUT-AHV-DMZ-DC01','NUT-AHV-DMZ-DC03']
    # else:
    #     return ['NUT-DMZ-DC01','NUT-DMZ-DC02']

def get_ahv_pc(datacenter):
    return {"dc1":"lu652.lalux.local","dc3":"lu653.lalux.local","NUT-AHV-DMZ-DC01":"lu652.lalux.local","NUT-AHV-DMZ-DC03":"lu653.lalux.local"}[datacenter]

def get_images(datacenter):
    images = {
        'dc1': ['rhel8-dc1'],
        'dc3': ['rhel8-dc3'],
        'NUT-AHV-DMZ-DC01': ['rhel8-dc1'],
        'NUT-AHV-DMZ-DC03': ['rhel8-dc3'],
    }

    return images.get(datacenter,[])

def get_clusters(datacenter):
    clusters = {
        'dc1': ['lu650.lalux.local'],
        'dc3': ['lu651.lalux.local'],        
        'NUT-AHV-DMZ-DC01': ['nut-ahv-dmz-dc1.lalux.local'],
        'NUT-AHV-DMZ-DC03': ['nut-ahv-dmz-dc3.lalux.local']
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


@app.route('/')
def index():
    return render_template('index.html',domains=get_domains(),environments=get_environment())

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
    return jsonify(get_ahv_subnets(datacenter))

@app.route('/get_storages')
def storages():
    cluster = request.args.get('cluster')
    print(cluster)
    return jsonify(get_ahv_storages(cluster))


@app.route('/submit', methods=["POST"])
def submit():
    try:
      yaml_data = process_vm_data(request.form)
      print("YAML Data:", yaml_data)  # Debug print      
      result = create_terraform_file(yaml_data)
      print("Terraform Config:", result)  # Debug print      

      # Create user-data content
      user_data = f"""
      #cloud-config
      hostname: {request.form['hostname']}
      fqdn: {request.form['hostname']}
      #Password configuration
      chpasswd:
        list: |
          localadmin:L@lux0123456789#
        expire: false

      # User & SSH configuration
      users:
      - name: localadmin
        ssh_authorized_keys:
          - "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGRDbtrK0KbhYmwgCzVHRoGXKjMIyNht6IJcPbHG/b+e gitlab-runner@rh-subman.lalux.local"      
      bootcmd:
        - nmcli con mod "System ens3" connection.id ens3
        - nmcli con mod ens3 ipv4.method manual ipv4.addresses {request.form['ip']}/{request.form.get('prefix', '24')} ipv4.gateway {request.form['gateway']} ipv4.dns "200.1.1.163" +ipv4.dns "200.1.1.218"
        - nmcli con up ens3
      """

      #return "OK",200
      pipeline_response = gitlab_trigger_pipeline(result,user_data)
      print(pipeline_response)

      return jsonify({
            "pipeline_id": pipeline_response.get('id'),
            "pipeline_url": pipeline_response.get('web_url'),
        }), 200      

    except Exception as e:
        app.logger.error(f"{e}")
        return jsonify({"FATAL": f"An error occured while processing your request {e}"}),500    
  
if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True,port=5500)
