output "azure-appid-clientid" {
  value = azuread_service_principal.github-oidc.application_id
}
