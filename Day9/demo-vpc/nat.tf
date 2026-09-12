resource "aws_nat_gateway" "nat1" {
    tags = {
        Name = "nat1"
    }
    availability_mode = "regional"
    ##regional is designed for two private subnets to use same NAT
    #availability_mode = "zonal" and also zonal has no EIP
    vpc_id = aws_vpc.vpc1.id
    #subnet_id = aws_subnet.private1.id
    connectivity_type = "public"
    allocation_id = aws_eip.eip1.id
    depends_on = [ aws_internet_gateway.igw1 ]
}