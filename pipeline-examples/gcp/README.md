# Pipeline Examples

Structure

- .circleci     - example circleci workflows
- azuredevops   - example azure-pipelines.yml and terraform to configure azure devops service connection/azure ad app registrion
- docker        - example dockerfile for rackspace tooling container used to execute python terraform wrapper.
- images        - screen shots used in this readme
- layers/       - example terraform that can be executed by the circleci or github workflows to read a test resource an confirm OIDC is working.

Assumes the cloud-provider-setup has been completed.

## GCP - CircleCI

Testing OIDC auth between CircleCI and GCP

Environment vars required for circle-ci
```
GCP_PROJECT_NUMBER = target project number! e.g. 1234567890
GCP_WIP_ID = Workload Identity Fed Pool ID e.g.  "circleci-oidc"
GCP_WIP_PROVIDER_ID = Workload Identity Fed Pool Provider ID e.g. "circleci-oidc-org-name"
GCP_SERVICE_ACCOUNT_EMAIL = GCP service account to impresonate e.g. mysa@my-gcp-project.iam.gserviceaccount.com

BACKEND_BUCKET = GCP cloud storage bucket used to store the state
BACKEND_PREFIX = terraform state prefix (key) for the state 

TF_VAR_var_project = gcp project id e.g. my-gcp-project
```

![](./images/gcp-circleci-vars.jpg)


## GCP - Azure DevOps

Tesing OIDC auth between AzureDevOps and GCP

To create an AzureDevOps connection to GCP..

1)  Create an AzureDevOps organisation and project
2)  Use the included terraform here to create a service connection and assoicated application ID
3)  Use the terraform in [cloud-provider-setup/gcp/azuredevops](../../cloud-provider-setup/gcp/azuredevops) to configure GCP with the application ID details.
4)  Create a pipeline using the example included here with the example variables below


Environment vars required for aazuredevops
```
GCP_PROJECT_NUMBER
GCP_PROJECT_NUMBER = target project number! e.g. 1234567890
GCP_WIP_ID = Workload Identity Fed Pool ID e.g.  "azuredevops-oidc"
GCP_WIP_PROVIDER_ID = Workload Identity Fed Pool Provider ID e.g. "azuredevops-oidc-org-name"
GCP_SERVICE_PROJECT_EMAIL = GCP service account to impresonate e.g. mysa@my-gcp-project.iam.gserviceaccount.com

BACKEND_BUCKET = GCP cloud storage bucket used to store the state
BACKEND_PREFIX = terraform state prefix (key) for the state 

TF_VAR_var_project = gcp project id e.g. my-gcp-project
```
![](./images/gcp-azuredevops-vars.jpg)

Useful reference: https://medium.com/google-cloud/accessing-google-cloud-apis-from-azure-devops-using-workload-identity-federation-6acc5ad1a071 

