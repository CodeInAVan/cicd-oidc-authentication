data "google_iam_policy" "azuredevops_devops" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      "principal://iam.googleapis.com/projects/${var.var_project-number}/locations/global/workloadIdentityPools/${var.var_azuredevops-poolid}/subject/${var.var_azuredevops-app-id}",
    ]
  }
  binding {
    role = "roles/iam.serviceAccountTokenCreator"
    members = [
      "principal://iam.googleapis.com/projects/${var.var_project-number}/locations/global/workloadIdentityPools/${var.var_azuredevops-poolid}/subject/${var.var_azuredevops-app-id}",
    ]
  }
}
