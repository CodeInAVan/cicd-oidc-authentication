



1) create identify provider 

https://circleci.com/docs/openid-connect-tokens/
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html

2) create IAM role

https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create

3) link identiy to provider

usage:

```
module "oidc-circleci-aws" {
  source                          = "./modules/oidc-circleci-aws"
  var_circleci-orgid          = "< circleci orgid >"
  var_circleci-project-id     = "< circleci projectid >"
  var_circleci-thumbprint_list    = ["${data.external.thumbprint.result.thumbprint}"]
  var_role_policy_arns = [
    "arn:aws:iam::aws:policy/< policy name >",
  ]
  var_role_name = "< AWS role name >"
}
```

To set the certificate thumbprint for the AWS oidc provider, a script has been included in ./bash/get_thumbprint.sh

Reference: https://github.com/hashicorp/terraform-provider-aws/issues/10104

This script is executed in a data block, like so:


```
data "external" "thumbprint" {
  program = ["${path.module}/bash/get_thumbprint.sh", "oidc.circleci.com"]
}
```

References:

![Hasicorp terraform module for oidc, used to create idenidy provider](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/v5.5.2/modules/iam-assumable-role-with-oidc)
