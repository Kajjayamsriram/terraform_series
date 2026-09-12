resource "aws_security_group" "sg" {
    tags = {
        Name = var.sg_name
    }
    description = var.sg_des
    vpc_id = var.vpc_id
    dynamic "ingress" {
        for_each = var.ingress_values
        content {
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidr
        }
    }
    dynamic "egress" {
        for_each = var.egress_values
        content {
            from_port = egress.value.port
            to_port = egress.value.port
            protocol = egress.value.protocol
            cidr_blocks =  egress.value.cidr
        }
    }
    
}