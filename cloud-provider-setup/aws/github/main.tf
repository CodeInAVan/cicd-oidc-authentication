module "oidc-github-aws" {
  source = "./modules/oidc-github-aws"
  var_role_policy_arns = [
    "arn:aws:iam::aws:policy/< policy name >",
  ]
  var_role_name              = "< aws role name >"
  var_github-thumbprint_list = ["${data.external.thumbprint.result.thumbprint}"]
  var_github-oidc-subject    = "repo:<org>/<repo>:environment:<environment>"
}


