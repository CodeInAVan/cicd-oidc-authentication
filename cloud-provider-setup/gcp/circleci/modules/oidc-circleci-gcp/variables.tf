
variable "var_circleci-orgid" {
  type = string
  description = "< circleci orgid > ID from circleci organisation"
}

variable "var_circleci-poolid" {
  type = string
  description = "Name of GCP workload identity pool"
}

variable "var_circleci-providerid" {
  type = string
  description = "Name of GCP workload identity pool provider"
}

variable "var_circleci-project-id" {
  type = string
  description = "< circleci projectid > ID from github project as displayed in circleci"
}

variable "var_project-id" {
  description = "GCP Project ID e.g. my-gcp-project-id"
  type = string
}

variable "var_project-number" {
  description = "GCP Project Number e.g. 1234567890"
  type = string
}

variable "var_circleci-service-account-id" {
  type = string
  description = "Name of Service Account to be created"
}

variable "var_circleci-service-account-roles" {
  type = list
  description = "List of GCP roles to grant service account"
}

variable "var_circleci-service-account-display-name" {
  type = string
  description = "Display Name of Service Account to be created"
}