data "aws_vpc" "vpcid" {
    default = true
}
resource "aws_security_group" "sg1" {
    name = var.name
    description = var.description
    vpc_id  = data.aws_vpc.vpcid.id
    dynamic "ingress" {
        for_each =  var.ingress_values
        content {
            from_port = ingress.value.port
            to_port = ingress.value.port
            protocol = ingress.value.protocol
            cidr_blocks = ingress.value.cidrs
        }
    }
    dynamic "egress" {
        for_each = var.egress_values
        content {
            from_port = egress.value.port
            to_port = egress.value.port
            protocol = egress.value.protocol
            cidr_blocks = egress.value.cidrs
        }
    }
}