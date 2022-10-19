
resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.var_azuredevops-poolid
  project                   = var.var_project-id
  provider                  = google-beta
}

resource "google_iam_workload_identity_pool_provider" "azuredevops" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.var_azuredevops-providerid
  attribute_mapping = {
    "google.subject" = "assertion.appid"
  }
  oidc {
    issuer_uri        = "https://sts.windows.net/${var.var_azure-tenant_id}"
    allowed_audiences = ["https://management.core.windows.net/"]
  }
  provider = google-beta
  project  = var.var_project-id
}

# create a service account
resource "google_service_account" "service_account_azuredevops_devops" {
  account_id   = var.var_azuredevops-service-account-id
  display_name = var.var_azuredevops-service-account-display-name

  project = var.var_project-id
}

# bind to wip but wait for the wip to be created or it errors!
resource "google_service_account_iam_policy" "devops-account-iam" {
  service_account_id = google_service_account.service_account_azuredevops_devops.name
  policy_data        = data.google_iam_policy.azuredevops_devops.policy_data
  provider           = google-beta
  depends_on = [
    google_iam_workload_identity_pool_provider.azuredevops
  ]
}

resource "google_project_iam_member" "service_project_owner_binding-azure-devops" {
  project = var.var_project-id

  for_each = toset(var.var_azuredevops-service-account-roles)

  role   = each.key
  member = "serviceAccount:${google_service_account.service_account_azuredevops_devops.email}"
}

