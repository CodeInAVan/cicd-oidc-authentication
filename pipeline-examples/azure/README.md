
# Pipeline Examples

Structure

- .circleci     - example circleci workflows
- .github       - example github actrion workflows
- docker        - example dockerfile for rackspace tooling container used to execute python terraform wrapper.
- images        - screen shots used in this readme
- layers/       - example terraform that can be executed by the circleci or github workflows to create a test resource an confirm OIDC is working.

Assumes the cloud-provider-setup has been completed.

## Azure - CircleCI

### Example workflows

- config-orb.yml - uses native circle ci orbs to create an environment with terraform
- config-docker.yml - uses a docker image with rackspace pipeline tools added and a python script to execute the terraform in the layers/ directory structure

Requires the project variables to be created as shown:

```
AZURE_CLIENT_ID - teh appid created in Azure AD (see "cloud-provider-setup")

AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID

BACKEND_ACCESS_KEY - access key from Azure storage group, needed until terraform backend supports OIDC (see issue https://github.com/hashicorp/terraform/issues/31802 )

BACKEND_RG - Resouce group of backend
BACKEND_SG - Storage group of backend     
BACKEND_CONTAINER - Container name of backend container e.g. tfstate
BACKEND_KEY - State Key e.g. terraform.tfstate

```

![](./images/circleci-variables.jpg)

## Azure Github Actions

### Example workflows

- 1_tfplan-az-cli.yml           - Authenticates with OIDC and runs just az cli test
- 2_tfplan-tf-oidc.yml          - Authenticates with OIDC and runs terraform plan from hashicorp/setup-terraform@v1 
- 3_tfplan_tf-docker_python.yml - Uses a rackspace tooling docker container, runs terraform using python scripts (using OIDC auth)

Requires the repo secrets to be created as shown:

```
AZURE_CLIENT_ID - the appid created in Azure AD (see "cloud-provider-setup")

AZURE_TENANT_ID
AZURE_SUBSCRIPTION_ID

BACKEND_ACCESS_KEY - IS NOT REQUIRED IN GITHUB ACTIONS

BACKEND_RG - Resouce group of backend
BACKEND_SG - Storage group of backend     
BACKEND_CONTAINER - Container name of backend container e.g. tfstate
BACKEND_KEY - State Key e.g. terraform.tfstate

```
![](./images/github-secrets.jpg)
