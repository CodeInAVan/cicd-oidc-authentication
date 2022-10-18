resource "random_string" "resource_code" {
  length  = 10
  special = false
  upper   = false
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key" {
  key_name   = "${random_string.resource_code.result}-key"
  public_key = tls_private_key.key.public_key_openssh
}