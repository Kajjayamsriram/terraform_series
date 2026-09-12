resource "aws_vpc" "vpc1" {
    tags= {
        Name = var.vpc_name
    }
    cidr_block = var.cidr
    enable_dns_hostnames = var.dns
    instance_tenancy = var.tenancy
}