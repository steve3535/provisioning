# This file is generated automatically. DO NOT EDIT MANUALLY.

###############################
# ESX NETWORKS
###############################

data "vsphere_network" "DMZ_AIA" {
  name          = "DMZ_AIA"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_Axway" {
  name          = "DMZ_Axway"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_DEV_ESP_CLI" {
  name          = "DMZ_DEV_ESP_CLI"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_DKV_CITRIX" {
  name          = "DMZ_DKV_CITRIX"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_DKV_WEB" {
  name          = "DMZ_DKV_WEB"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_Excitor" {
  name          = "DMZ_EXT_Excitor"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_MDM_DEVICE" {
  name          = "DMZ_EXT_MDM_DEVICE"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_MDM_GW" {
  name          = "DMZ_EXT_MDM_GW"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_Oracle_Mgmt" {
  name          = "DMZ_EXT_Oracle_Mgmt"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_SANTE_PRO" {
  name          = "DMZ_EXT_SANTE_PRO"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_EXT_SANTE_TST" {
  name          = "DMZ_EXT_SANTE_TST"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_INT_MKT_INTERNET" {
  name          = "DMZ_INT_MKT_INTERNET"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU108" {
  name          = "DMZ_LU108"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU108sql" {
  name          = "DMZ_LU108sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU109" {
  name          = "DMZ_LU109"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU109sql" {
  name          = "DMZ_LU109sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU177" {
  name          = "DMZ_LU177"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU184" {
  name          = "DMZ_LU184"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU37_LU147" {
  name          = "DMZ_LU37_LU147"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU37sql_LU147sql" {
  name          = "DMZ_LU37sql_LU147sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU38_LU148" {
  name          = "DMZ_LU38_LU148"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU38sql_LU148sql" {
  name          = "DMZ_LU38sql_LU148sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU38sql_LU149sql" {
  name          = "DMZ_LU38sql_LU149sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU61" {
  name          = "DMZ_LU61"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU61sql" {
  name          = "DMZ_LU61sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU62" {
  name          = "DMZ_LU62"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU62sql" {
  name          = "DMZ_LU62sql"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU85" {
  name          = "DMZ_LU85"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU87" {
  name          = "DMZ_LU87"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_LU97" {
  name          = "DMZ_LU97"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_EXT" {
  name          = "DMZ_MGMT_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_INT" {
  name          = "DMZ_MGMT_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_MGMT_VLAN20" {
  name          = "DMZ_MGMT_VLAN20"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_AGS_WS" {
  name          = "DMZ_PRO_AGS_WS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_API_GW" {
  name          = "DMZ_PRO_API_GW"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_API_MGMT" {
  name          = "DMZ_PRO_API_MGMT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_APPMOBIL" {
  name          = "DMZ_PRO_APPMOBIL"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_APP_FRN" {
  name          = "DMZ_PRO_APP_FRN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_AUTH_MOBIL" {
  name          = "DMZ_PRO_AUTH_MOBIL"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_AZUR" {
  name          = "DMZ_PRO_AZUR"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_BCEE_TARIF" {
  name          = "DMZ_PRO_BCEE_TARIF"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_BITB_GW" {
  name          = "DMZ_PRO_BITB_GW"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_DATANYWHERE" {
  name          = "DMZ_PRO_DATANYWHERE"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_DKV_SAFENET" {
  name          = "DMZ_PRO_DKV_SAFENET"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESB" {
  name          = "DMZ_PRO_ESB"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESP_CLI_AD" {
  name          = "DMZ_PRO_ESP_CLI_AD"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESP_CLI_AUTH" {
  name          = "DMZ_PRO_ESP_CLI_AUTH"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESP_CLI_FRN" {
  name          = "DMZ_PRO_ESP_CLI_FRN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESP_CLI_SRV" {
  name          = "DMZ_PRO_ESP_CLI_SRV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_ESP_CLI_WS" {
  name          = "DMZ_PRO_ESP_CLI_WS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_EXALEAD" {
  name          = "DMZ_PRO_EXALEAD"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_GAPP" {
  name          = "DMZ_PRO_GAPP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_INT_RAD" {
  name          = "DMZ_PRO_INT_RAD"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_INT_RHEL_MGMT" {
  name          = "DMZ_PRO_INT_RHEL_MGMT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_INT_WAP" {
  name          = "DMZ_PRO_INT_WAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_LSP_API" {
  name          = "DMZ_PRO_LSP-API"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_MARKETING" {
  name          = "DMZ_PRO_MARKETING"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_PROP_CONTRAT" {
  name          = "DMZ_PRO_PROP_CONTRAT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_PROTECT_CLIENT" {
  name          = "DMZ_PRO_PROTECT_CLIENT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SAP_HANA" {
  name          = "DMZ_PRO_SAP_HANA"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SHAREPT_APP" {
  name          = "DMZ_PRO_SHAREPT_APP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SHAREPT_FEEX" {
  name          = "DMZ_PRO_SHAREPT_FEEX"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SHAREPT_FEIN" {
  name          = "DMZ_PRO_SHAREPT_FEIN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SHAREPT_VASC" {
  name          = "DMZ_PRO_SHAREPT_VASC"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SNCA" {
  name          = "DMZ_PRO_SNCA"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PRO_SPINETIX" {
  name          = "DMZ_PRO_SPINETIX"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_PenConnect" {
  name          = "DMZ_PenConnect"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_QlikView" {
  name          = "DMZ_QlikView"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TEST" {
  name          = "DMZ_TEST"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ADFS_IC" {
  name          = "DMZ_TST_ADFS_IC"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_AGS_WS" {
  name          = "DMZ_TST_AGS_WS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_APPMOBIL" {
  name          = "DMZ_TST_APPMOBIL"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_APP_FRN" {
  name          = "DMZ_TST_APP_FRN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_AUTH_MOBIL" {
  name          = "DMZ_TST_AUTH_MOBIL"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESB" {
  name          = "DMZ_TST_ESB"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESP_CLI_AD" {
  name          = "DMZ_TST_ESP_CLI_AD"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESP_CLI_AUTH" {
  name          = "DMZ_TST_ESP_CLI_AUTH"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESP_CLI_FRN" {
  name          = "DMZ_TST_ESP_CLI_FRN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESP_CLI_SRV" {
  name          = "DMZ_TST_ESP_CLI_SRV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_ESP_CLI_WS" {
  name          = "DMZ_TST_ESP_CLI_WS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_EXALEAD" {
  name          = "DMZ_TST_EXALEAD"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_LSP_API" {
  name          = "DMZ_TST_LSP-API"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_MAX_ICS" {
  name          = "DMZ_TST_MAX-ICS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_PROP_CONTRAT" {
  name          = "DMZ_TST_PROP_CONTRAT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_SHAREPT_APP" {
  name          = "DMZ_TST_SHAREPT_APP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_SHAREPT_FEEX" {
  name          = "DMZ_TST_SHAREPT_FEEX"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_SHAREPT_FEIN" {
  name          = "DMZ_TST_SHAREPT_FEIN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "DMZ_TST_SHAREPT_VASC" {
  name          = "DMZ_TST_SHAREPT_VASC"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_AIA" {
  name          = "PPR_AIA"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS" {
  name          = "PPR_APPLICATIONS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS_APROBAT" {
  name          = "PPR_APPLICATIONS_APROBAT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS_LN" {
  name          = "PPR_APPLICATIONS_LN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_APPLICATIONS_LV" {
  name          = "PPR_APPLICATIONS_LV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_CRM" {
  name          = "PPR_CRM"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_EPTS" {
  name          = "PPR_EPTS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_FRONTS_PURS_EXT" {
  name          = "PPR_FRONTS_PURS_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_FRONTS_PURS_INT" {
  name          = "PPR_FRONTS_PURS_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_INNOVAS" {
  name          = "PPR_INNOVAS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_MAGIC" {
  name          = "PPR_MAGIC"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_REVERSE_PROXY_EXT" {
  name          = "PPR_REVERSE_PROXY_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_REVERSE_PROXY_INT" {
  name          = "PPR_REVERSE_PROXY_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SCAN_ANTIVIRUS_EXT" {
  name          = "PPR_SCAN_ANTIVIRUS_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES" {
  name          = "PPR_SERVICES"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_APROBAT" {
  name          = "PPR_SERVICES_APROBAT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_DKV" {
  name          = "PPR_SERVICES_DKV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_LN" {
  name          = "PPR_SERVICES_LN"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_SERVICES_LV" {
  name          = "PPR_SERVICES_LV"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_TECH_COMPONENTS" {
  name          = "PPR_TECH_COMPONENTS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PPR_VS_F5_EXT" {
  name          = "PPR_VS_F5_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_ANALYTICS_EXT" {
  name          = "PRO_ANALYTICS_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_ANTIVIRUS" {
  name          = "PRO_ANTIVIRUS"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_AUTH_EXT" {
  name          = "PRO_AUTH_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_AUTH_INT" {
  name          = "PRO_AUTH_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_AXWAY" {
  name          = "PRO_AXWAY"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_DEPLOY_APP" {
  name          = "PRO_DEPLOY_APP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_ESIGN_INT" {
  name          = "PRO_ESIGN_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_MDM_GW_EXT" {
  name          = "PRO_MDM_GW_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_MDM_SRV_EXT" {
  name          = "PRO_MDM_SRV_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_PROXY_EXT" {
  name          = "PRO_PROXY_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_PUBLIC_SITE_EXT" {
  name          = "PRO_PUBLIC_SITE_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_SAP" {
  name          = "PRO_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_SAP_ROUTER_EXT" {
  name          = "PRO_SAP_ROUTER_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "PRO_VM_PRESTA" {
  name          = "PRO_VM_PRESTA"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_AUTH_EXT" {
  name          = "REC_AUTH_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_AUTH_INT" {
  name          = "REC_AUTH_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_ESIGN_INT" {
  name          = "REC_ESIGN_INT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_PUBLIC_SITE_EXT" {
  name          = "REC_PUBLIC_SITE_EXT"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "REC_SAP" {
  name          = "REC_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "SYNC_CHECKPOINT_VE" {
  name          = "SYNC_CHECKPOINT_VE"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "TST_AXWAY" {
  name          = "TST_AXWAY"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "TST_SAP" {
  name          = "TST_SAP"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

data "vsphere_network" "ntnx_internal_pg" {
  name          = "ntnx-internal-pg"
  datacenter_id = data.vsphere_datacenter.esx_dc.id
}

