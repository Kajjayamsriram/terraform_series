resource "aws_internet_gateway" "igw1" {
    tags = {
        Name = var.igw_name
    }
    vpc_id = var.vpc_id
}
