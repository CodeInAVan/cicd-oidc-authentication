resource "azuredevops_serviceendpoint_azurerm" "example" {
  project_id                = data.azuredevops_project.example.id
  service_endpoint_name     = data.azuredevops_project.example.name
  azurerm_spn_tenantid      = var.var_azurerm_spn_tenantid
  azurerm_subscription_id   = var.var_azure-subscription
  azurerm_subscription_name = var.var_azurerm_subscription_name
}

# add the application URI using CLI (a bit of a hack sorry)
data "external" "thumbprint" {
  program = ["${path.module}/bash/appuri.sh", "${data.azuread_application.example.application_id}"]

  depends_on = [
    azuredevops_serviceendpoint_azurerm.example
  ]
}

