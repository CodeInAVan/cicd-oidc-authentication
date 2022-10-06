data "azuread_client_config" "current" {}

data "azurerm_subscription" "primary" {
  subscription_id = var.var_azure-subscription
}

