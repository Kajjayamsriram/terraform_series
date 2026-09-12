data "aws_vpc" "vpc1" {
    default = true
}

resource "aws_security_group" "sg1" {
    name = var.name
    description = var.description
    vpc_id      = data.aws_vpc.vpc1.id
    dynamic "ingress" {
        for_each = var.ingress_ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}