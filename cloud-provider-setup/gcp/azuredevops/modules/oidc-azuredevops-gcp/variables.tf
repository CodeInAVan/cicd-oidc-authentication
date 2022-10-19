
variable "var_azuredevops-poolid" {
  type        = string
  description = "Name of GCP workload identity pool"
}

variable "var_azuredevops-providerid" {
  type        = string
  description = "Name of GCP workload identity pool provider"
}

variable "var_project-id" {
  description = "GCP Project ID e.g. my-gcp-project-id"
  type        = string
}

variable "var_project-number" {
  description = "GCP Project Number e.g. 1234567890"
  type        = string
}

variable "var_azuredevops-service-account-id" {
  type        = string
  description = "Name of Service Account to be created"
}

variable "var_azuredevops-service-account-roles" {
  type        = list(any)
  description = "List of GCP roles to grant service account"
}

variable "var_azuredevops-service-account-display-name" {
  type        = string
  description = "Display Name of Service Account to be created"
}

variable "var_azure-tenant_id" {
  type        = string
  description = "target azure tenant id"
}

variable "var_azuredevops-app-id" {
  type        = string
  description = "target azure application id - linked to azuredevops service connection"
}