data "external" "thumbprint" {
  program = ["${path.module}/bash/get_thumbprint.sh", "oidc.circleci.com"]
}
