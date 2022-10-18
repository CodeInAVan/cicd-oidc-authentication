output "oidc-provider-cert-thumprint" {
  value = data.external.thumbprint.result.thumbprint
}