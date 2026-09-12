resource "aws_subnet" "subnets" {
    vpc_id = var.vpc_id
    for_each = var.subnets

    availability_zone = each.value.az
    cidr_block = each.value.cidr
    map_public_ip_on_launch = each.value.ip
    tags = {
        Name= each.key
    }
}