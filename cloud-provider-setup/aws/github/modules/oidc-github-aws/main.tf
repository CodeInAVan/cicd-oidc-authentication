resource "aws_iam_openid_connect_provider" "default" {
  # issuer
  url = "https://token.actions.githubusercontent.com"

  #audience
  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = var.var_github-thumbprint_list
}

module "iam_assumable_role_with_oidc" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = var.var_role_name

  tags = {
    Role = "role-with-oidc"
  }

  provider_url = "https://token.actions.githubusercontent.com"

  role_policy_arns           = var.var_role_policy_arns
  number_of_role_policy_arns = 1

  oidc_fully_qualified_audiences = ["sts.amazonaws.com"]
  oidc_fully_qualified_subjects  = ["${var.var_github-oidc-subject}"]
}
