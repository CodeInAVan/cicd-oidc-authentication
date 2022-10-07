# Configuring the OIDC trust with the cloud

The cloud OIDC trust configuration is unique to each cloud provider and each CI/CD platform, the key elements of the cloud providers configuration:

- [Configuring the OIDC trust with the cloud](#configuring-the-oidc-trust-with-the-cloud)
  - [Azure App registrations](#azure-app-registrations)
    - [Application Federated Credentials:](#application-federated-credentials)
    - [Circle CI example credential:](#circle-ci-example-credential)
    - [Github Actions example credential:](#github-actions-example-credential)
  - [GCP Workload Identity Federation](#gcp-workload-identity-federation)
    - [GCP Workload Identity Federation Pools](#gcp-workload-identity-federation-pools)
  - [Useful references:](#useful-references)


## Azure App registrations

Azure OIDC authentication is defined with “Azure Active Directory” “App registrations”.

| NOTE: [from Azure notes here ](https://learn.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp#important-considerations-and-restrictions) A maximum of 20 federated identity credentials can be added to an application or user-assigned managed identity. |
| --- |

An application needs to be created, and associated with a service principle, with the required roles in the subscription. The Application (client) ID highlighted below in red is important and needs to be provided to the CI/CD platform.

![](../images/azure-circleci-application.jpg)

Once the application is created, navigate to a resource (for example a subscription) and use “Add assignment” to grant the application access rights.

![](../images/azure-application-role-assignment-subscription.jpg)

![](../images/azure-application-role-assignment-subscription-app.jpg)


Examples of the terraform and az cli required to configure an application and the service principle are included in this repository.

These create an application, with one or more federated credentials:

### Application Federated Credentials: 

![](../images/azure-circleci-application-secrets.jpg)

### Circle CI example credential:

As Circle CI hard codes the user into the OIDC subject you need to create multiple credentials if a larger team is executing the pipeline.

| NOTE: [from Azure notes here ](https://learn.microsoft.com/en-us/azure/active-directory/develop/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp#important-considerations-and-restrictions) A maximum of 20 federated identity credentials can be added to an application or user-assigned managed identity. |
| --- |

![](../images/azure-circleci-federated-user-detail.jpg)

### Github Actions example credential:

![](../images/azure-github-federated-user-detail.jpg)




## GCP Workload Identity Federation

### GCP Workload Identity Federation Pools

GCP OIDC authentication is defined with IAM -> Workload Identity Federation -> Workload Identity Pools

An identity pool needs to be created: 

![](./images/gcp-wip.jpg)

within the identity pool a provider is defined:

![](./images/gcp-wip-details.jpg)

and an service account is connected to the pool:

![](./images/gcp-wip-details-sa.jpg)

Examples of the terraform arequired to configure a workload identity pool, provider and service account are included in this repository.

NOTE: GCP does a soft delete of a Workload Identiy Pool (and retains the object name) when terraform destroys it, so it cannot be re-created with the same name!

## Useful references:

Circleci (covers project settings and GCP/AWS) : https://circleci.com/docs/openid-connect-tokens

Github Actions (sections on AWS/GCP and Azure): https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect 

Azure and Github Actions, useful walk through: https://www.cloudwithchris.com/blog/using-oidc-github-actions-azure-swa/ 

Azure and Github actions MS guid: https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux 

Circleci and GCP: https://harryhodge.co.uk/posts/2022/07/keyless-authentication-from-circleci-to-google-cloud/ 

GCP OIDC walk through: https://discuss.circleci.com/t/walk-through-oidc-to-gcp/44224


