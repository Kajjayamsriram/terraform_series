data "aws_vpc" "vpc1" {
    default = true
}
# data "aws_route_table" "rt" {
#     vpc_id = data.aws_vpc.vpc1.id
#     filter {
#         name = "association.main"
#         values = ["true"]
#     }
# }
data "aws_subnet" "sub1" {
    vpc_id = data.aws_vpc.vpc1.id
    filter {
        name = "availability-zone"
        values = ["us-east-1a"]
    }
}
data "aws_security_group" "sg_def" {
    name = "MY-SG"
}
locals {
    instances = {
        dev = {
           instance_type = "t3.micro"
           ami = "ami-0bdc7d025135d7b49"
           subnet_id = aws_subnet.public1.id
           vpc_security_group_ids = aws_security_group.sg1.id
           key_name = "Luffy-kp"
           volume_size=10
        }
        default = {
           instance_type = "t3.micro"
           ami = "ami-0bdc7d025135d7b49"
           subnet_id = data.aws_subnet.sub1.id
           vpc_security_group_ids = data.aws_security_group.sg_def.id
           key_name = "Luffy-kp"
           volume_size=10
        }
    }

}

resource "aws_instance" "inst" {
    for_each = local.instances
    tags = {
        Name = each.key
    }
    instance_type = each.value.instance_type
    ami = each.value.ami
    subnet_id = each.value.subnet_id
    vpc_security_group_ids = [each.value.vpc_security_group_ids]
    key_name = each.value.key_name
    root_block_device {
      volume_size = each.value.volume_size
    }
    user_data = file("dev-deploy.sh")
}


# resource "aws_route_table_association" "assc" {
#     route_table_id = data.aws_route_table.rt.id
#     subnet_id = data.aws_subnet.sub1.id 
# }