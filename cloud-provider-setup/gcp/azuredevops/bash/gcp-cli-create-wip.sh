# VARIABLES USED HERE 
# <Azure Application ID> - from Azure portal
# <Azure Tenant ID> - from azure portal
# <GCP Service Account Name> - name of service account to create
# <GCP Project Number> - numerical ID of project 
# <GCP Project Name> - project Name
# <GCP Workload Identity Pool ID> 
# <GCP Workload Identity Provider ID>

# Create a workload identity pool
gcloud iam workload-identity-pools create <GCP Workload Identity Pool ID> \
    --location="global" \
    --display-name="<GCP Workload Identity Pool ID>"
    
    
# Create a workload identity provider for the Azure Tenant
gcloud iam workload-identity-pools providers create-oidc <GCP Workload Identity Provider ID> \
    --location="global" \
    --workload-identity-pool="<GCP Workload Identity Pool ID>" \
    --issuer-uri="https://sts.windows.net/<Azure Tenant ID>/" \
    --attribute-mapping="google.subject=assertion.appid" \
    --allowed-audiences="https://management.core.windows.net/"
    
    
# Create a Service Account and allow the Azure Service Principal to access it
gcloud iam service-accounts create <GCP Service Account Name>

PRINCIPAL="principal://iam.googleapis.com/projects/<GCP Project Number>/locations/global/workloadIdentityPools/<GCP Workload Identity Pool ID>/subject/<Azure Application ID>"

gcloud iam service-accounts add-iam-policy-binding \
    <GCP Service Account Name>@<GCP Project Name>.iam.gserviceaccount.com \
    --member="$PRINCIPAL" \
    --role="roles/iam.serviceAccountUser"

# grant Azure application principle rights to request a token
gcloud iam service-accounts add-iam-policy-binding \
    <GCP Service Account Name> \
    --member="$PRINCIPAL" \
    --role="roles/iam.serviceAccountTokenCreator"

# grant service account some rights
gcloud projects add-iam-policy-binding <GCP Project Name> \
    --member="serviceAccount:<GCP Service Account Name>@<GCP Project Name>.iam.gserviceaccount.com" \
    --role="roles/compute.admin"
    
gcloud projects add-iam-policy-binding <GCP Project Name> \
    --member="serviceAccount:<GCP Service Account Name>@<GCP Project Name>.iam.gserviceaccount.com" \
    --role="roles/storage.admin"
