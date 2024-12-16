## Prereqs
### DNS entries should be made
### Linux standard firewall ports should be opened


## Terraform
## Initialize it 
* create main.tf and variables.tf to start with :)
* best practice is to have the latest version:
  * in the Dowmloads/ section, grab the cli for linux for https://terraform.io - actually it downloads the corresponding repo
  * `sudo dnf -y install terraform`  - in case there was already a previous version, it will be overwritten
  * check the version: `terraform version` - will also give the providers version
  * check your providers: `terraform providers`
* To install the providers needed:
  * Go to the directory that contains the tf configuration file  
  * `<https_proxy=http://proxy:port> terraform init`  
  * Note that a .terraforms folder will get created, containing the binaries of the requested providers - should be put in .gitignore because of the size  
  * a file .terraform.hcl.lock will have the exact content of your providers definition  - should be part of the versioning
* for an upgrade of the providers: `terraform init --upgrade`
* in our current use case: the providers have been specified at the top of main.tf:
  ```
  terraform {
  required_providers {
    nutanix = {
        source = "nutanix/nutanix"
        }
    vsphere = {
        source = "hashicorp/vsphere"
        }
  }
  }
  ```

## main.tf
  * this file is the squeleton for everything else  
  * Typically we will have:  
    * the definition of the required providers  
    * the details of the providers (credentials to the providers) - refrenced by variables defined in variables.tf


## variables.tf

## Service Account permissions 
1. created on Nutanix the service account **ntx-api-sa** on both PEs and PCs  
2. Had to use the new IAM in PC to grant full VM admin access to the sa account (Select Role and add an Auth. Policy)  

## Ansible
* the gitlab-runner should also be the Ansible controller, hence ansible binaries should be available for gitlab-runner user
* the satellite enrollment relies on community.general collection: hence, ensure its installed and available under gitlab-runner user:
  ```bash
  sudo su - gitlab-runner
  https_proxy=http://vsl-pro-squ-001:3128 ansible-galaxy collection list
  ```  
  If not present, as gitlab-runner, install it:  
  ```bash
  export https_proxy=xxx
  export http_proxy=xxx
  cat <<EOF >.ansible.cfg
  [galaxy]
  server_list = galaxy

  [galaxy_server.galaxy]
  url = https://galaxy.ansible.com
  proxy = http://vsl-pro-squ-001:3128
  ansible-galaxy collection install community.general 
  EOF
  ```  
* the mount module used in the playbook leverages the collection **ansible.posix**

## IDM
* IDM admin password expires every 3 months.remember to adjust its value in *backend/.env*  