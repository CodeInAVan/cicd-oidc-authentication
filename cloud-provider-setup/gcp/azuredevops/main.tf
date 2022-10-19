module "oidc-azuredevops-gcp" {
  source                             = "./modules/oidc-azuredevops-gcp"
  var_azuredevops-orgid              = "< azuredevops orgid >"
  var_azuredevops-project-id         = "< azuredevops projectid >"
  var_azuredevops-poolid             = "< gcp workload identify pool name > e.g. azuredevops-oidc"
  var_azuredevops-providerid         = "< gcp workload identify pool name > azuredevops-projectname"
  var_azuredevops-service-account-id = "< gcp service account > e.g. projectname-azuredevops-sa"
  var_azuredevops-service-account-roles = [
    "roles/compute.XXX",
    "roles/compute.YYY",
    "roles/XXX.admin"
  ]
  var_azuredevops-service-account-display-name = "Service Account - azuredevops dev ops access"
  var_project-id                               = "<gcp project id>"
  var_project-number                           = "<gcp project number>"
}


