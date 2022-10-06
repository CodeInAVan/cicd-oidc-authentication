# copying gitlab example https://docs.gitlab.com/ee/ci/cloud_services/azure/

export var_circleci-appid="< azure application name>"
export var_circleci-orgid="< circleci orgid >"
export var_circleci-project-id="< circleci projectid >"
export var_azure-subscription-role="Reader"
export var_azure-subscription="< azure subscription id>"

### you need to set these in each section below
### export var_circleci-user-id="< circleci userid >"
### export var_circleci-username="< circleci username >"
###

export issuer="https://oidc.circleci.com/org/$var_circleci_orgid"
export audience="$var_circleci_orgid"
export subject="org/$var_circleci_orgid/project/$var_circleci_project_id/user/$var_circleci_user-id"
export description="Circleci service account federated identity"

# create appid and spn
appId=$(az ad app create --display-name $var_circleci_appid --query appId -otsv)
az ad sp create --id $appId --query appId -otsv
az role assignment create --assignee $appId --role $var_azure_subscription_role --scope /subscriptions/$var_azure_subscription
objectId=$(az ad app show --id $appId --query id -otsv)

# MAKE A NOTE OF THE APPLICATION ID, YOU NEED THIS IN CIRCLECI 
echo NOTE THIS Application ID: $objectId

# repeat for each user
##### SET USER HERE #####
export var_circleci-user-id="< circleci userid >"
export var_circleci-username="< circleci username >"
######
export issuer="https://oidc.circleci.com/org/$var_circleci_orgid"
export audience="$var_circleci_orgid"
export subject="org/$var_circleci_orgid/project/$var_circleci_project_id/user/$var_circleci_user_id"
export description="Circleci service account federated identity"


cat <<EOF > body.json
{
  "name": "circleci_federated-identity-$var_circleci_username",
  "issuer": "$issuer",
  "subject": "$subject",
  "description": "$description",
  "audiences": [
    "$audience"
  ]
}
EOF
az rest --method POST --uri "https://graph.microsoft.com/beta/applications/$objectId/federatedIdentityCredentials" --body @body.json


# repeat for each user
##### SET USER HERE #####
export var_circleci-user-id="< circleci userid >"
export var_circleci-username="< circleci username >"
######
export issuer="https://oidc.circleci.com/org/$var_circleci_orgid"
export audience="$var_circleci_orgid"
export subject=org/$var_circleci_orgid/project/$var_circleci_project_id/user/$var_circleci_user_id
export description="Circleci service account federated identity"


cat <<EOF > body.json
{
  "name": "circleci_federated-identity-$var_circleci_username",
  "issuer": "$issuer",
  "subject": "$subject",
  "description": "$description",
  "audiences": [
    "$audience"
  ]
}
EOF
az rest --method POST --uri "https://graph.microsoft.com/beta/applications/$objectId/federatedIdentityCredentials" --body @body.json



#### END OF USER CREATION
echo NOTE THIS Application ID: $objectId