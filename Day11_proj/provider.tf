terraform {
    required_providers {
      aws ={
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
    backend "s3" {
        bucket = "bloodbankbucket0910"
        key = "dev/terraform.tfstate"
        use_lockfile = true
        region = "us-east-1"
    }
}
provider "aws" {
    region = "us-east-1"
}