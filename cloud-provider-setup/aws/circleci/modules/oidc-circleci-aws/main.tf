resource "aws_iam_openid_connect_provider" "default" {
  # issuer
  url = "https://oidc.circleci.com/org/${var.var_circleci-orgid}"

  #audience
  client_id_list = [
    "${var.var_circleci-orgid}",
  ]

  thumbprint_list = var.var_circleci-thumbprint_list
}

module "iam_assumable_role_with_oidc" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = var.var_role_name

  tags = {
    Role = "role-with-oidc"
  }

  provider_url = "https://oidc.circleci.com/org/${var.var_circleci-orgid}"

  role_policy_arns           = var.var_role_policy_arns
  number_of_role_policy_arns = 1

  oidc_fully_qualified_audiences = ["${var.var_circleci-orgid}"]
  oidc_subjects_with_wildcards   = ["org/${var.var_circleci-orgid}/project/${var.var_circleci-project-id}/user/*"]
}
