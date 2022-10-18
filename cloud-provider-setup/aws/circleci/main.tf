
module "oidc-circleci-aws" {
  source                       = "./modules/oidc-circleci-aws"
  var_circleci-orgid           = "468c1373-6c34-4f99-b937-fa478df094b0"
  var_circleci-project-id      = "55e16558-a226-4a1c-8d9c-1807d42c94b0"
  var_circleci-thumbprint_list = ["${data.external.thumbprint.result.thumbprint}"]
  var_role_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
  var_role_name = "mr-test-circleci-role-with-oidc2"
}

module "oidc-circleci-aws" {
  source                       = "./modules/oidc-circleci-aws"
  var_circleci-orgid           = "< circleci orgid >"
  var_circleci-project-id      = "< circleci projectid >"
  var_circleci-thumbprint_list = ["${data.external.thumbprint.result.thumbprint}"]
  var_role_policy_arns = [
    "arn:aws:iam::aws:policy/< policy name >",
  ]
  var_role_name = "< AWS role name >"
}



