# Terraform
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

  
  
  
