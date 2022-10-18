variable "var_github-thumbprint_list" {
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

variable "var_github-oidc-subject" {
  type        = string
  description = "oidc token subject from github repo:octo-org/octo-repo:ref:refs/heads/octo-branch"

}