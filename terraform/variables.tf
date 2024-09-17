variable "nutanix_username" {
    description = "NUTANIX PC ADMIN USERNAME"
    type = string
    sensitive = true  
}

variable "nutanix_password" {
    description = "NUTANIX PC ADMIN PASSWORD"
    type = string
    sensitive = true  
}

variable "prism_central_dc1" {
    description = "NUTANIX DC1 PC SERVER"
    type = string    
    default = "lu652.lalux.local"
}

variable "prism_central_dc3" {
    description = "NUTANIX DC3 PC SERVER"
    type = string    
    default = "lu653.lalux.local"
}

variable "vsphere_username" {
    description = "VSPHERE ADMIN USERNAME"
    type = string
    sensitive = true 
}

variable "vsphere_password" {
    description = "VSPHERE ADMIN PASSWORD"
    type = string
    sensitive = true 
}

variable "vsphere_server" {
    description = "VSPHERE SERVER"
    type = string
    default = "lu309.lalux.local"
}

variable "nutanix_endpoints" {
    type = map(string)
    default = {
      "dc1" = "lu652.lalux.local"
      "dc3" = "lu653.lalux.local"
    }
  
}

variable "nutanix_clusters" {
    type = map(string)
    default = {
      "lu650" = "dc1"
      "lu651" = "dc3"
    }
}

variable "nutanix_images" {
    type = map(string)
    default = {
      "rhel8-dc1" = "dc1"
      "rhel8-dc3" = "dc3"
    } 
}

variable "nutanix_storages" {
    type = map(string)
    default = {
      "NUT_AHV_DC1_01" = "lu650"
      "NUT_AHV_DC3_01" = "lu650"
      "NUT_AHV_DC1_RH_PGSQL" = "lu650"
      "NUT_AHV_DC1_01" = "lu651"
      "NUT_AHV_DC3_01" = "lu651"
      "NUT_AHV_DC1_RH_PGSQL" = "lu651"
    } 
}
