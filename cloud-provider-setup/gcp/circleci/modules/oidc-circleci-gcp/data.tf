data "google_iam_policy" "circleci_devops" {
  binding {
    role = "roles/iam.workloadIdentityUser"
    members = [
      # using circleci org id
       "principalSet://iam.googleapis.com/projects/${var.var_project-number}/locations/global/workloadIdentityPools/${var.var_circleci-poolid}/attribute.org_id/${var.var_circleci-orgid}"
      # using circleci project ID 
      #"principalSet://iam.googleapis.com/projects/${var.var_project_number}/locations/global/workloadIdentityPools/${var.var_circleci-poolid}/attribute.project_id/${var.var_circleci-projectid}"
    ]
  }
}
