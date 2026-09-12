resource "aws_instance" "tfserver" {
    tags = {
        Name = "tfserver"
    }
    ami = "ami-0bdc7d025135d7b49"
    instance_type = "t3.micro"
    key_name = "Luffy-kp"
    availability_zone = "us-east-1c"
    vpc_security_group_ids = ["subnet-0f3c2001bb9ab6950"]
    root_block_device {
      volume_size = 8
    }
}