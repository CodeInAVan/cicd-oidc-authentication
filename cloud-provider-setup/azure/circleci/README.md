Example oidc appid creation in azure for circleci

Terraform example, see modules/oidc-circleci-azure and main.tf for execution example.

Bash example is folder "bash"

Structure

- bash - shell script to create appid with azure cli
- modules/oidc-circleci-azure - module for terraform, creates azure appid
- main.tf - example module call
  
  Terraform module call example is shown below, note: circleci oidc is tied to a user, so every user who is executing the pipeline needs to be added as a unique federated credential, there is a "system user" that is used by the scheduled pipelines. Only way i've foudn to discover it's ID is to run a scheduled pipeline and when teh OIDC authentication fails it shows you the subject string used with the sending user ID.


```
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
        "systemuser"="< schedule user id>"
    }
}

```