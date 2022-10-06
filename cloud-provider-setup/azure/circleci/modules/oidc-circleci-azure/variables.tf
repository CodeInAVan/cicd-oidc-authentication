
variable "var_circleci-orgid" {
  type = string
  description = "< circleci orgid > ID from circleci organisation"
}

variable "var_circleci-appid" {
  type = string
  description = "< azure application name> azure object name for oidc appid"
}

variable "var_circleci-credid" {
  type = string
  description = "azure object name prefix (username is added to this string) for oidc federated credential e.g. circleci-federated-identity-[]"
  default = "circleci-federated-identity"
}

variable "var_circleci-project-id" {
  type = string
  description = "< circleci projectid > ID from github project as displayed in circleci"
}

variable "var_circleci-user-ids" {
  description = "map of key=value pairs, username=circleci userid"
  type = map(string)
}

variable "var_azure-subscription" {
  type = string
  description = "target azure subscription id"
}

variable "var_azure-subscription-role" {
  type = string
  description = "target azure subscription role"
  default     = "Contributor"
}
