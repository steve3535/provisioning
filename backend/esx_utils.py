import ssl
from pyVim.connect import SmartConnect, Disconnect
from dotenv import load_dotenv
import os

def connect_to_vcenter():
    load_dotenv()
    username = os.getenv('ESX_USERNAME')
    password = os.getenv('ESX_PASSWORD')
    vcenter = os.getenv('VCENTER_HOST')
    
    context = ssl.create_default_context()
    context.check_hostname = False
    context.verify_mode = ssl.CERT_NONE
    
    try:
        si = SmartConnect(host=vcenter, user=username, pwd=password, sslContext=context)
        return si
    except Exception as e:
        print(f"Error connecting to vCenter: {e}")
        return None

def disconnect_from_vcenter(si):
    if si:
        Disconnect(si)