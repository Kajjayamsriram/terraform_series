resource "aws_security_group" "sg" {
    for_each = var.sg

    name = "${each.key}-sg"
    description = each.value.description
    vpc_id = var.vpc_id
}

resource "aws_vpc_security_group_egress_rule" "e_rule" {
    for_each = var.e_rule
    security_group_id            = aws_security_group.sg[each.value.sg].id
    referenced_security_group_id = (each.value.destination_sg !=null ? aws_security_group.sg[each.value.destination_sg].id : null)
    from_port = each.value.port
    to_port = each.value.port
    ip_protocol = each.value.protocol
    cidr_ipv4 = (each.value.destination_sg == null ? "0.0.0.0/0" : null)
}
resource "aws_vpc_security_group_ingress_rule" "in_rule" {
    for_each = var.in_rule
    security_group_id            = aws_security_group.sg[each.value.sg].id
    #referenced_security_group_id = aws_security_group.sg[each.value.source_sg].id
    referenced_security_group_id =(each.value.source_sg !=null ? aws_security_group.sg[each.value.source_sg].id : null)
    from_port = each.value.port
    to_port = each.value.port
    ip_protocol = each.value.protocol
    cidr_ipv4 = (each.value.source_sg == null ? "0.0.0.0/0" : null)
}