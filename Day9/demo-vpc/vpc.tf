resource "aws_vpc" "vpc1" {
    tags = {
        Name = "vpc-dev"
    }
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"
    enable_dns_hostnames = true
}