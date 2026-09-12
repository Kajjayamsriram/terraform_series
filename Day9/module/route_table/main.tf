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

resource "aws_route" "pvt_route" {
    route_table_id = aws_route_table.pvt_rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw
}
resource "aws_route" "pub_route"{
    route_table_id = aws_route_table.pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = var.igw
}
resource "aws_route_table_association" "pub1_ass" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = var.subnet_ids["public1"]
}
resource "aws_route_table_association" "pub2_ass"{
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = var.subnet_ids["public2"]
}

resource "aws_route_table_association" "pvt1_ass"{
    route_table_id = aws_route_table.pvt_rt.id
    subnet_id = var.subnet_ids["private1"]
}
resource "aws_route_table_association" "pvt2_ass"{
    route_table_id = aws_route_table.pvt_rt.id
    subnet_id = var.subnet_ids["private2"]
}