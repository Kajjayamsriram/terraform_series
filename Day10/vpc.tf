resource "aws_vpc" "vpc1" {
    tags = {
        Name = "demo_vpc"
    }
    cidr_block = "10.0.0.0/24"
    instance_tenancy = "default"
    enable_dns_hostnames = true
}

resource "aws_subnet" "subnets" {
    for_each = var.subnets
    vpc_id = aws_vpc.vpc1.id
    availability_zone = each.value.az
    cidr_block = each.value.cidr
    map_public_ip_on_launch = each.value.pub
    tags = {
         Name = each.key
    }
    depends_on = [ aws_vpc.vpc1 ]
}


resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "igw1"
    }
    depends_on = [ aws_vpc.subnets ]
}

resource "aws_eip" "eip1" {
    tags = {
        Name = "eip1"
    }
    domain = "vpc"
    depends_on = [ aws_internet_gateway.igw1 ]
}

resource "aws_nat_gateway" "nat1" {
    tags  ={
        Name = "nat_gw"
    }
    
    availability_mode = "regional"
    vpc_id = aws_vpc.vpc1.id
    connectivity_type = "public"
    allocation_id = aws_eip.eip1.id
    depends_on = [ aws_internet_gateway.igw1, aws_eip.eip1 ]
}

resource "aws_route_table" "pvt_rt" {
    tags = {
        Name = "pvt_rt"
    }
    vpc_id = aws_vpc.vpc1.id
    depends_on = [ aws_subnet.subnets ]
}
resource "aws_route_table" "pub_rt" {
    tags = {
        Name = "pub_rt"
    }
    vpc_id = aws_vpc.vpc1.id
    depends_on = [ aws_subnet.subnets]
}

resource "aws_route_table_association" "association" {
    for_each = var.subnets
    subnet_id = aws_subnet.subnets[each.key].id
    route_table_id = each.value.pub ? aws_route_table.pub_rt.id : aws_route_table.pvt_rt.id
    depends_on = [ aws_subnet.subnets ]
}
resource "aws_route" "pub_rt" {
    route_table_id = aws_route_table.pub_rt.id
    gateway_id = aws_internet_gateway.igw1.id
    destination_cidr_block = "0.0.0.0/0"
    depends_on = [ aws_subnet.subnets, aws_route.pub_rt, aws_internet_gateway.igw1 ]
}

resource "aws_route" "pvt_rt" {
    route_table_id = aws_route_table.pvt_rt.id
    nat_gateway_id = aws_nat_gateway.nat1.id
    destination_cidr_block = "0.0.0.0/0"
    depends_on = [ aws_subnet.subnets, aws_route.pvt_rt, aws_nat_gateway.nat1 ]
}