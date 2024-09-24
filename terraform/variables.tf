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
    type = map(object({
        name: string 
        dc: string
    }))
    default = {
      lu650 = {"name":"LU650", "dc":"dc1"}
      lu651 = {"name":"LU651", "dc":"dc3"}
    }
}

variable "nutanix_images" {
    type = map(object({
       name: string 
       dc: string 
    }))
    default = {
      rhel8-dc1 = {"name":"RHEL8STD-latest","dc":"dc1"} 
      rhel8-dc3 = {"name":"RHEL8STD-latest","dc":"dc3"} 
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

variable "lu650_storages" {
    type = map(string)
}

variable "lu651_storages" {
    type = map(string)
}

variable "dc1_subnets" {
    type = map(string)
}

variable "dc3_subnets" {
    type = map(string)
}
