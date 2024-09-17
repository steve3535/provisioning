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
}

variable "prism_central_dc3" {
    description = "NUTANIX DC3 PC SERVER"
    type = string    
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
}