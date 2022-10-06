# Configuring the OIDC trust with the cloud

The cloud OIDC trust configuration is unique to each cloud provider and each CI/CD platform, the key elements of the cloud providers configuration:

## Azure App registrations

Azure OIDC authentication is defined with “Azure Active Directory” “App registrations”.

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

![](../images/azure-circleci-federated-user-detail.jpg)

### Github Actions example credential:

![](../images/azure-github-federated-user-detail.jpg)