
variable "var_circleci-orgid" {
  type        = string
  description = "< circleci orgid > ID from circleci organisation"
}

variable "var_circleci-project-id" {
  type        = string
  description = "< circleci projectid > ID from github project as displayed in circleci"
}

variable "var_circleci-thumbprint_list" {
  type        = set(string)
  description = "list of oidc provider thumbprints"
}

variable "var_role_policy_arns" {
  type        = set(string)
  description = "list of policy arns to assign the oidc idendity"
}

variable "var_role_name" {
  type        = string
  description = "name of aws role"
}