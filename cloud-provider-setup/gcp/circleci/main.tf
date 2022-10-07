module "oidc-circleci-gcp" {
    source = "./modules/oidc-circleci-gcp"
    var_circleci-orgid="< circleci orgid >"
    var_circleci-project-id="< circleci projectid >"
    var_circleci-poolid="< gcp workload identify pool name > e.g. circleci-oidc"
    var_circleci-providerid="< gcp workload identify pool name > circleci-projectname"
    var_circleci-service-account-id="< gcp service account > e.g. projectname-circleci-sa"
    var_circleci-service-account-roles=[
    "roles/compute.XXX",
    "roles/compute.YYY",
    "roles/XXX.admin"
    ]
    var_circleci-service-account-display-name="Service Account - circleci dev ops access"
    var_project-id="<gcp project id>"
    var_project-number="<gcp project number>"
}