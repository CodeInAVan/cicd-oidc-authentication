

# create app registration
resource "azuread_application" "github-oidc" {
  display_name = var.var_github-appid
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "github-oidc" {
  application_id               = azuread_application.github-oidc.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

#create federated credential
resource "azuread_application_federated_identity_credential" "github-oidc" {
  application_object_id = azuread_application.github-oidc.object_id
  display_name          = "${var.var_github-credid}"
  description           = "Github Actions service account federated identity"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "${var.var_github-oidc-subject}"
}

# assign rights to credential - set principle role
resource "azurerm_role_assignment" "circelci-oidc-role" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = var.var_azure-subscription-role
  principal_id         = azuread_service_principal.github-oidc.object_id
}



