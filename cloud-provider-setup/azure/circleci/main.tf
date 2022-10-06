module "oidc-circleci-azure" {
    source = "./modules/oidc-circleci-azure"
    var_circleci-appid="< azure application name>"
    var_circleci-orgid="< circleci orgid >"
    var_circleci-project-id="< circleci projectid >"
    var_azure-subscription-role="Contributor"
    var_azure-subscription="< azure subscription id>"
    var_circleci-credid="circleci-federated-identity"
    var_circleci-user-ids={
        "user1"="< user id >"
        "user2"="< user2 id >"
    }
}









