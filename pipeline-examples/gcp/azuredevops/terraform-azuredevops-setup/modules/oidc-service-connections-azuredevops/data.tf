data "azuredevops_project" "example" {
  name = var.var_azuredevops_project
}

data "azuread_application" "example" {
  display_name = "${var.var_azuredevops_org}-${data.azuredevops_project.example.name}-${azuredevops_serviceendpoint_azurerm.example.azurerm_subscription_id}"
}

