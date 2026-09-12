resource "aws_route_table" "pvt_rt" {
    tags = {
        Name = "private_rt"
    }
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat1.id
    }
    #Best approach use route in aws_route resource block 
    depends_on = [ aws_nat_gateway.nat1 ]
}
resource "aws_route_table" "pub_rt" {
    tags = {
        Name = "public_rt"
    }
    vpc_id = aws_vpc.vpc1.id
    depends_on = [ aws_internet_gateway.igw1 ]
}
resource "aws_route_table_association" "private1" {
    route_table_id = aws_route_table.pvt_rt.id
    subnet_id = aws_subnet.private1.id
    depends_on = [ aws_route_table.pvt_rt ]
}
resource "aws_route_table_association" "private2" {
    route_table_id = aws_route_table.pvt_rt.id
    subnet_id = aws_subnet.private2.id
    depends_on = [ aws_route_table.pvt_rt ]
}
resource "aws_route_table_association" "public1" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.public1.id
    depends_on = [ aws_route_table.pub_rt ]
}
resource "aws_route_table_association" "public2" {
    route_table_id = aws_route_table.pub_rt.id
    subnet_id = aws_subnet.public2.id
    depends_on = [ aws_route_table.pub_rt ]
}