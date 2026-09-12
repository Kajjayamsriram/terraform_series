terraform {
    required_providers {
      aws = {
        source ="hashicorp/aws"
        version = "~>6.0"
      }
    }
}
provider "aws" {
    region = "us-east-1"
    access_key = data.vault_generic_secret.aws.data["access_key"]
    secret_key = data.vault_generic_secret.aws.data["secret_key"]
}
data "vault_generic_secret" "aws" {
    path = "secret/aws"
}
provider "vault" {
  address = ""
  token = var.token
}