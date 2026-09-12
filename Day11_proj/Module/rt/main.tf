resource "aws_route_table" "pub_rt" {
  tags = {
    Name = var.pub_rt_name
  }
  vpc_id = var.vpc_id
}

resource "aws_route_table" "pvt_rt" {
  tags = {
    Name = var.pvt_rt_name
  }
  vpc_id = var.vpc_id
}

resource "aws_route_table_association" "rt_assoc" {
    for_each = var.subnets
    route_table_id = each.value.ip ? aws_route_table.pub_rt.id : aws_route_table.pvt_rt.id
    subnet_id = each.value.id
}

resource "aws_route" "pub_route" {
    route_table_id = aws_route_table.pub_rt.id
    gateway_id = var.igw
    destination_cidr_block = var.cidr_pub
}
resource "aws_route" "pvt_route" {
    route_table_id = aws_route_table.pvt_rt.id
    nat_gateway_id = var.nat
    destination_cidr_block = var.cidr_pvt
}