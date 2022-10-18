
# Pipeline Examples

Structure

- .circleci     - example circleci workflows

- docker        - example dockerfile for rackspace tooling container used to execute python terraform wrapper.
- images        - screen shots used in this readme
- layers/       - example terraform that can be executed by the circleci or github workflows to create a test resource an confirm OIDC is working.

Assumes the cloud-provider-setup has been completed.

## AWS - CircleCI

CircleCI workflows must be configured with a context to enable OIDC. See detail here : https://circleci.com/docs/openid-connect-tokens 

Steps to enable OIDC in CircleCI

  1.    Create an Identity provder and IAM role in AWS (see notes [here](../../cloud-provider-setup/aws/circleci/README.md) )
  2.    Define a context in your circleci organisation (https://circleci.com/docs/openid-connect-tokens)
  3.    Define project level environment variables (see list below)
  4.    Define a workflow with the context enabled

```
workflows:
  my-workflow:
    jobs:
      - run-tests:
          context:
            - my-context
```

  1.   AWS CLI uses the environment variable CIRCLECI_OIDC_TOKEN to access the token for Terraform and AZ cli.



### Example workflows

- config-oidc-test.yml - this uses aws cli to authenticate and confirm your role
- config-orb.yml - uses native circle ci orbs to create an environment with terraform and aws cli
- config-docker.yml - uses a docker image with rackspace pipeline tools added and a python script to execute the terraform in the layers/ directory structure
  - Note: this uses a container: codeinavan/pipeline-toolbox-aws:latest created using the Dockerfile [here](docker/Dockerfile).
  - Also note example has a context name defined, this needs to be updated to reflect your environment.

Requires the project variables to be created as shown:

```
AWS_ROLE_ARN - the role created in AWS (see "cloud-provider-setup")
AWS_DEFAULT_REGION
BACKEND_DYNAMODB_TABLE - dynamo db table for backend locking
BACKEND_BUCKET - S3 bucket for backend   
BACKEND_KEY - State Key e.g. terraform.tfstate

```

![](./images/circleci-variables.jpg)

## AWS Github Actions 

GitHub workflows must be configured with an id-token permission (see detail here) to enable OIDC. 

Steps to enable OIDC in GitHub Actions:
1.  Create an Identity provder and IAM role in AWS (see notes [here](../../cloud-provider-setup/aws/circleci/README.md) )
2.	Define repository level secrets

```
AWS_ROLE_ARN - the role created in AWS (see "cloud-provider-setup")
AWS_DEFAULT_REGION
BACKEND_DYNAMODB_TABLE - dynamo db table for backend locking
BACKEND_BUCKET - S3 bucket for backend   
BACKEND_KEY - State Key e.g. terraform.tfstate
```

3.	Set permissions within a workflow to allow token access


See example workflows in this repo for a full pipeline using the above technique and also for execution using a Docker container to execute a python based Terraform wrapper.


### Example workflows

- 1_tfplan-aws-cli.yml           - Authenticates with OIDC and runs just aws cli test
- 2_tfplan-aws-tfplan.yml          - Authenticates with OIDC and runs terraform plan from hashicorp/setup-terraform@v1 
- 3_tfplan_tf-docker_python.yml - Uses a rackspace tooling docker container, runs terraform using python scripts (using OIDC auth)

Requires the repo secrets to be created as shown:

```
AWS_ROLE_ARN - the role created in AWS (see "cloud-provider-setup")
AWS_DEFAULT_REGION
BACKEND_DYNAMODB_TABLE - dynamo db table for backend locking
BACKEND_BUCKET - S3 bucket for backend   
BACKEND_KEY - State Key e.g. terraform.tfstate

```
![](./images/github-secrets.jpg)

## Useful references

Circleci (covers project settings and GCP/AWS) : https://circleci.com/docs/openid-connect-tokens

Github Actions (sections on AWS/GCP and Azure): https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect

