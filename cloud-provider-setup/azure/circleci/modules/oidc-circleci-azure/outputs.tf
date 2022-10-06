output "azure-appid-clientid" {
  value = azuread_service_principal.circleci-oidc.application_id
}
