
resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.var_circleci-poolid
  project                   = var.var_project-id
  provider                  = google-beta
}

resource "google_iam_workload_identity_pool_provider" "circelci" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.var_circleci-providerid
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.org_id"     = "assertion.aud"
    "attribute.audience"   = "assertion.aud"
    "attribute.project_id" = "assertion.sub.extract('/project/{project_id}/')"
  }
  oidc {
    issuer_uri        = "https://oidc.circleci.com/org/${var.var_circleci-orgid}"
    allowed_audiences = ["${var.var_circleci-orgid}"]
  }
  provider = google-beta
  project  = var.var_project-id
}

# create a service account
resource "google_service_account" "service_account_circleci_devops" {
  account_id   = var.var_circleci-service-account-id
  display_name = var.var_circleci-service-account-display-name

  project = var.var_project-id
}


# bind to wip
resource "google_service_account_iam_policy" "devops-account-iam" {
  service_account_id = google_service_account.service_account_circleci_devops.name
  policy_data        = data.google_iam_policy.circleci_devops.policy_data
  provider           = google-beta
  depends_on = [
    google_iam_workload_identity_pool_provider.circelci
  ]
}


resource "google_project_iam_member" "service_project_owner_binding-azure-devops" {
  project = var.var_project-id

  for_each = toset(var.var_circleci-service-account-roles)

  role   = each.key
  member = "serviceAccount:${google_service_account.service_account_circleci_devops.email}"
}

