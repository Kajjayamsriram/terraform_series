resource "aws_nat_gateway" "nat" {
    tags = {
        Name = var.nat_name
    }
    availability_mode = var.av_mode
    vpc_id = var.vpc_id
    connectivity_type = var.con_type
    allocation_id = var.eip
}