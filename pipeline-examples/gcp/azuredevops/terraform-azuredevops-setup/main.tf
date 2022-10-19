
module "oidc-service-connections-azuredevops" {
  source                        = "./modules/oidc-service-connections-azuredevops"
  var_azurerm_spn_tenantid      = "< azuredevops azure tenant id >"
  var_azure-subscription        = "< azuredevops azure subscription id >"
  var_azuredevops_project       = "< azuredevops existing project name >"
  var_azuredevops_org           = "< azuredevops organisation name >"
  var_azurerm_subscription_name = "< azuredevops azure subscription name >"
}

## NOTE THE PROVIDER.TF ALSO MUST BE CONFIGURED

