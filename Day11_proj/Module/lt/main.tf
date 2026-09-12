resource "aws_launch_template" "lt" {
    name = var.lt_name
    tag_specifications {
      resource_type = "instance"
      tags ={
        Name = var.inst_name
      }
    }
    description = var.lt_des
    image_id = var.image_id
    instance_type = var.itype
    vpc_security_group_ids = [ var.sg ]
    key_name = var.key

    block_device_mappings {
      device_name = "/dev/xvda"
      ebs {
        volume_size = var.inst_vol
      }
    }

    user_data = var.user_data
}