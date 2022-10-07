Example oidc appid creation in gcp for circleci

Terraform example, see modules/oidc-circleci-gcp and main.tf for execution example.

Structure

- modules/oidc-circleci-gcp - module for terraform, creates gcp workload identity pool and provider, creates a service account and links them.
- main.tf - example module call
  
  Terraform module call example is shown below.


```
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
```


## Notes

GCP does a soft delete of a Workload Identiy Pool (and retains the object name) when terraform destroys it, so it cannot be re-created with the same name!

## Useful references:

Circleci (covers project settings and GCP/AWS) : https://circleci.com/docs/openid-connect-tokens

Github Actions (sections on AWS/GCP and Azure): https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect 

Circleci and GCP: https://harryhodge.co.uk/posts/2022/07/keyless-authentication-from-circleci-to-google-cloud/ 

GCP OIDC walk through: https://discuss.circleci.com/t/walk-through-oidc-to-gcp/44224
