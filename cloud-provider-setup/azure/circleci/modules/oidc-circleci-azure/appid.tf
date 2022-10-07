

# create app registration
resource "azuread_application" "circleci-oidc" {
  display_name = var.var_circleci-appid
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "circleci-oidc" {
  application_id               = azuread_application.circleci-oidc.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

#create federated credential
resource "azuread_application_federated_identity_credential" "circleci-oidc" {
  for_each              = var.var_circleci-user-ids
  application_object_id = azuread_application.circleci-oidc.object_id
  display_name          = "${var.var_circleci-credid}-${each.key}"
  description           = "Circleci service account federated identity"
  audiences             = ["${var.var_circleci-orgid}"]
  issuer                = "https://oidc.circleci.com/org/${var.var_circleci-orgid}"
  subject               = "org/${var.var_circleci-orgid}/project/${var.var_circleci-project-id}/user/${each.value}"
}

# assign rights to credential - set principle role
resource "azurerm_role_assignment" "circelci-oidc-role" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = var.var_azure-subscription-role
  principal_id         = azuread_service_principal.circleci-oidc.object_id
}



