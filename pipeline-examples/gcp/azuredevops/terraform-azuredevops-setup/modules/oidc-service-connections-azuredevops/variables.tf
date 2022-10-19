variable "var_azure-subscription" {
  type        = string
  description = "target azure subscription id"
}

variable "var_azurerm_subscription_name" {
  type        = string
  description = "target azure subscription name"
}


variable "var_azurerm_spn_tenantid" {
  type        = string
  description = "target azure tenant id"
}

variable "var_azuredevops_project" {
  type        = string
  description = "azuredevops project the connection is being created within"
}


# variable "var_azuredevops_org_service_url" {
#   type        = string
#   description = "azuredevops url"
# }


# variable "var_azuredevops_personal_access_token" {
#   type        = string
#   description = "azuredevops org personal access token"
# }

variable "var_azuredevops_org" {
  type        = string
  description = "azuredevops org name"
}


