resource "aws_nat_gateway" "nat1" {
    tags = {
        Name = var.nat_name
    }
    allocation_id = var.alloc_id
    availability_mode = var.az_mode
    vpc_id = var.vpc_id
    connectivity_type = var.con_type
}