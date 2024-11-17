# This file is generated automatically. DO NOT EDIT MANUALLY.

###############################
# ESX DATASTORES
###############################

data "vsphere_datastore" "Metro_DC3_to_DC1" {
  name          = "Metro_DC3_to_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "Metro_DC1_to_DC3" {
  name          = "Metro_DC1_to_DC3"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290203_A" {
  name          = "NTNX-local-ds-24SH5N290203-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290197_A" {
  name          = "NTNX-local-ds-24SH5N290197-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290202_A" {
  name          = "NTNX-local-ds-24SH5N290202-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "esx_cisco_02_Local" {
  name          = "esx-cisco-02_Local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC1_01" {
  name          = "NUT_DMZ_INT_DC1_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC1_to_DC2" {
  name          = "NUT_DMZ_EXT_DC1_to_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240158_A" {
  name          = "NTNX-local-ds-19FM3E240158-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_ISO_DC1" {
  name          = "NUT_DMZ_ISO_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240169_A" {
  name          = "NTNX-local-ds-19FM3E240169-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_ESX_DC1" {
  name          = "NUT_ESX_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC2_01" {
  name          = "NUT_DMZ_INT_DC2_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_20FM5A050127_A" {
  name          = "NTNX-local-ds-20FM5A050127-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC1_to_DC2" {
  name          = "NUT_DMZ_INT_DC1_to_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240158_B" {
  name          = "NTNX-local-ds-19FM3E240158-B"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_ESX_DC3" {
  name          = "NUT_ESX_DC3"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_22SH5H520153_A" {
  name          = "NTNX-local-ds-22SH5H520153-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC1_01" {
  name          = "NUT_DMZ_EXT_DC1_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC2_01" {
  name          = "NUT_DMZ_EXT_DC2_01"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC2_to_DC1" {
  name          = "NUT_DMZ_INT_DC2_to_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290189_A" {
  name          = "NTNX-local-ds-24SH5N290189-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC02_Async" {
  name          = "NUT_DMZ_EXT_DC02_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_SHPT_DC1_Async" {
  name          = "NUT_DMZ_INT_SHPT_DC1_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240168_A" {
  name          = "NTNX-local-ds-19FM3E240168-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_ISO_DC2" {
  name          = "NUT_DMZ_ISO_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC2_to_DC1" {
  name          = "NUT_DMZ_EXT_DC2_to_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290186_A" {
  name          = "NTNX-local-ds-24SH5N290186-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_22SH5H520176_A" {
  name          = "NTNX-local-ds-22SH5H520176-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_EXT_DC01_Async" {
  name          = "NUT_DMZ_EXT_DC01_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC02_Async" {
  name          = "NUT_DMZ_INT_DC02_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240168_B" {
  name          = "NTNX-local-ds-19FM3E240168-B"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_SHPT_DC2_Async" {
  name          = "NUT_DMZ_INT_SHPT_DC2_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_SHPT_DC2" {
  name          = "NUT_DMZ_INT_SHPT_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_24SH5N290195_A" {
  name          = "NTNX-local-ds-24SH5N290195-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_DC01_Async" {
  name          = "NUT_DMZ_INT_DC01_Async"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_SHPT_DC1" {
  name          = "NUT_DMZ_INT_SHPT_DC1"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "esx_cisco_01_Local" {
  name          = "esx-cisco-01_Local"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NUT_DMZ_INT_SHPT_DC1_to_DC2" {
  name          = "NUT_DMZ_INT_SHPT_DC1_to_DC2"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_datastore" "NTNX_local_ds_19FM3E240161_A" {
  name          = "NTNX-local-ds-19FM3E240161-A"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

