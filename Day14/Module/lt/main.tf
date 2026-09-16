data "aws_key_pair" "kp" {
    key_name = var.kname
}

resource "aws_launch_template" "eks"{
    name = var.lt_name
    description = var.lt_des

    image_id = var.image_id
    instance_type = var.itype
    vpc_security_group_ids = [ var.sg ]
    key_name = data.aws_key_pair.kp.key_name
    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
          volume_size = var.lt_vol_size
        }
    }
    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = var.inst_name
        }
    }
}