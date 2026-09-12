resource "aws_vpc" "vpc" {
    tags = {
        Name = var.vpc_name
    }
    cidr_block = var.cidr_block
    instance_tenancy = var.tenancy
    enable_dns_hostnames = var.dns
}