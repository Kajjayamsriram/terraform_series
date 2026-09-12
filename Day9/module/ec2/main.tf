resource "aws_instance" "inst" {
    for_each = var.ec2_inst
    tags = {
        Name = each.key
    }
    instance_type = each.value.itype
    ami = each.value.ami_id
    vpc_security_group_ids = [var.security_group_id]
    subnet_id = var.subnet_ids[each.value.subnet_name]
    key_name = var.kname
    root_block_device {
        volume_size = each.value.vol_size
    }
}