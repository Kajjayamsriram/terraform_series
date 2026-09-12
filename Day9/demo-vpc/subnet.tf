resource "aws_subnet" "private1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "private1"
    }
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/27"
}
resource "aws_subnet" "private2" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "private2"
    }
    availability_zone = "us-east-1b"
    cidr_block = "10.0.0.32/27"
}

resource "aws_subnet" "public1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "public1"
    }
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.64/27"
    map_public_ip_on_launch = true
}
resource "aws_subnet" "public2" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "public2"
    }
    availability_zone = "us-east-1b"
    cidr_block = "10.0.0.128/27"
    map_public_ip_on_launch = true
}