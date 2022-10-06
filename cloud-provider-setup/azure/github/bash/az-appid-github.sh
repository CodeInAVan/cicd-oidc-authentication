# copying gitlab example https://docs.gitlab.com/ee/ci/cloud_services/azure/

export var_azure-subscription-role="Contributor"
export var_azure-subscription="< azure subscription id>"
export var_github_appid="< azure application name>"
export var_github_oidc_subject="repo:<org>/<repo>:environment:<environment>"

export issuer="https://token.actions.githubusercontent.com"
export audience="api://AzureADTokenExchange"
export subject=$var_github_oidc_subject
export description="Github service account federated identity"

# create appid and spn
appId=$(az ad app create --display-name $var_github_appid --query appId -otsv)
az ad sp create --id $appId --query appId -otsv
az role assignment create --assignee $appId --role $var_azure_subscription_role --scope /subscriptions/$var_azure_subscription
objectId=$(az ad app show --id $appId --query id -otsv)

cat <<EOF > body.json
{
  "name": "github_federated-identity",
  "issuer": "$issuer",
  "subject": "$subject",
  "description": "$description",
  "audiences": [
    "$audience"
  ]
}
EOF
az rest --method POST --uri "https://graph.microsoft.com/beta/applications/$objectId/federatedIdentityCredentials" --body @body.json

# MAKE A NOTE OF THE APPLICATION ID, YOU NEED THIS IN github 
echo NOTE THIS Application ID: $objectId
