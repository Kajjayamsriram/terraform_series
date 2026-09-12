terraform {
    required_version = ">= 1.5.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
    backend "s3" {
        bucket = "tbucket.random.18907"
        key = "test/terraform.tfstate"
        use_lockfile = true
        region = "us-east-1"
    }
}
provider "aws" {
    region = "us-east-1"
}