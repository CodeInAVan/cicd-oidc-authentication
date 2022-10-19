Example oidc appid creation in gcp for azuredevops

Terraform example, see modules/oidc-azuredevops-gcp and main.tf for execution example.

To create an AzureDevOps connection to GCP..

1)  Create an AzureDevOps organisation and project (see [pipeline-examples/gcp/azuredevops](../../../pipeline-examples/gcp/azuredevops) )
2)  Use the included terraform there to create a service connection and assoicated application ID
3)  Use the terraform in this folder to configure GCP with the application ID created in step 2.
4)  Create a pipeline using the example included here with the example in [pipeline-examples/gcp/azuredevops](../../../pipeline-examples/gcp/azuredevops)

Bash example is folder "bash"

Structure

- bash - shell script to create appid with gcp cli
- modules/oidc-azuredevops-gcp - module for terraform, creates gcp appid
- main.tf - example module call
  
  Terraform module call example is shown below


```
module "oidc-azuredevops-gcp" {
    source = "./modules/oidc-azuredevops-gcp"
    var_azuredevops-app-id="< azure application id (service connection app registration, client/app id)>"
    var_azuredevops-poolid             = "< workload federation pool name >"
    var_azuredevops-providerid         = "< workload federation pool - provider name >"
    var_azuredevops-service-account-id = "< service account name >"
    var_azure-tenant_id = "< azure tenant id >"
    var_azuredevops-service-account-roles = [
      "roles/compute.XXX",
      "roles/compute.YYY",
      "roles/ZZZ.admin"
    ]
    var_azuredevops-service-account-display-name = "Service Account - azuredevops dev ops access"
    var_project-id                            = "< GCP Project ID >"
    var_project-number                        = "< GCP Project Number >"
```

# Useful References for GCP OIDC:

https://azuredevops.com/blog/openid-connect-identity-tokens/

https://medium.com/google-cloud/accessing-google-cloud-apis-from-azure-devops-using-workload-identity-federation-6acc5ad1a071 

# Notes

GCP does a soft delete of a Workload Identiy Pool (and retains the object name) when terraform destroys it, so it cannot be re-created with the same name!