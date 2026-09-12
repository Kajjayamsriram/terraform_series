data "aws_vpc" "vpc" {
    default = true
}
data "aws_route_table" "default_rt" {
    vpc_id = data.aws_vpc.vpc.id
    filter {
        name = "association.main"
        values = ["true"]
    }
}
resource "aws_vpc_peering_connection" "peer" {
    vpc_id = aws_vpc.vpc1.id
    peer_vpc_id = data.aws_vpc.vpc.id
    auto_accept = true
    tags = {
        Name = "vpc1_default"
    }
    depends_on = [ aws_vpc.vpc1 ]
}

# resource "aws_vpc_peering_connection" "peer1" {
#     vpc_id = data.aws_vpc.vpc.id
#     peer_vpc_id = aws_vpc.vpc1.id
#     auto_accept = true
#     tags = {
#         Name = "default_vpc1"
#     }
#     depends_on = [ aws_vpc.vpc1 ]
# }

resource "aws_route" "vpc1_default" {
    #route_table_id = aws_vpc.vpc1.default_route_table_id
    route_table_id = aws_route_table.pub_rt.id
    destination_cidr_block = data.aws_vpc.vpc.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
resource "aws_route" "pub_int" {
    route_table_id = aws_route_table.pub_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
}
resource "aws_route" "default_vpc1" {
    route_table_id = data.aws_route_table.default_rt.id
    destination_cidr_block = aws_vpc.vpc1.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}