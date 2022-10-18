data "external" "thumbprint" {
  program = ["${path.module}/bash/get_thumbprint.sh", "token.actions.githubusercontent.com"]
}
