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
  address = "http://54.163.67.136:8200"
  token = var.token
}
ephemeral "vault_kv_secret_v2" "docker" {
  mount = "secret"
  name  = "docker"
}
