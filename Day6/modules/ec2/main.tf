resource "aws_instance" "web" {
    tags = var.tags
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    availability_zone = var.availability_zone
    vpc_security_group_ids = var.vpc_security_group_ids
    root_block_device {
        volume_size = var.volume_size
    }
}