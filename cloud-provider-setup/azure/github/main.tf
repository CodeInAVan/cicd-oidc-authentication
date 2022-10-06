module "oidc-github-azure" {
    source = "./modules/oidc-github-azure"
    var_github-appid="< azure application name>"
    var_azure-subscription-role="Contributor"
    var_azure-subscription="< azure subscription id >"
    var_github-credid="github-federated-identity"
    var_github-oidc-subject="repo:<org>/<repo>:environment:<environment>"
}









