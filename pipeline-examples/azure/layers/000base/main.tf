resource "random_string" "resource_code" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_resource_group" "testrg" {
  name     = "oidc-testing-rg-${random_string.resource_code.result}"
  location = "UKSouth"
}
