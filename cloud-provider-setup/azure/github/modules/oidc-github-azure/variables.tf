
variable "var_azure-subscription" {
  type        = string
  description = "target azure subscription id"
}

variable "var_azure-subscription-role" {
  type        = string
  description = "target azure subscription role"
  default     = "Contributor"
}

variable "var_github-credid" {
  description = "azure object name for oidc credential"
  type        = string
}

variable "var_github-oidc-subject" {
  description = "Subject string from github actions in format repo:<org>/<repo>:environment:<environment>"
  type        = string
}

variable "var_github-appid" {
  type        = string
  description = "< azure application name> azure object name for oidc appid"
}
