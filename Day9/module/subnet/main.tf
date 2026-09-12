resource "aws_subnet" "subnet" {
    vpc_id = var.vpc_id
    for_each = var.subnet
    tags = {
        Name = "${each.key}"
    }
    availability_zone = each.value.az
    cidr_block = each.value.subnet_cidr
    map_public_ip_on_launch = each.value.pub_ip
}