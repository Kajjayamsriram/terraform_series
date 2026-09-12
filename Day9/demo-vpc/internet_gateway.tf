resource "aws_internet_gateway" "igw1" {
    tags = {
        Name = "igw1"
    }
    vpc_id = aws_vpc.vpc1.id
}