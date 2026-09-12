# provider "aws" {
#     region = "us-east-1"
# }

data "aws_subnet" "subone" {
    filter {
      name = "availability-zone"
      values = ["us-east-1c"]
    }
}

data "aws_security_group" "sg1" {
    name = "MY-SG"
}

resource "aws_instance" "inst2" {
    tags = {
        Name = "tfserver"
    }
    ami = "ami-004f790b835b26145"
    instance_type = "t3.micro"
    key_name = "Luffy-kp"
    subnet_id = data.aws_subnet.subone.id
    vpc_security_group_ids = [data.aws_security_group.sg1.id]
    root_block_device {
        volume_type = "gp3"
        volume_size = 10
        delete_on_termination = true
        encrypted = false
    }
}