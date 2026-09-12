provider "aws" {
    region = "us-east-1"
}
resource "aws_instance" "inst1" {
    tags = {
        Name = "tserver"
        Environment = "Development"
    }
    ami = "ami-004f790b835b26145"
    instance_type = "t3.micro"
    key_name = "Luffy-kp"
    subnet_id = "subnet-0a168cf8c57a99160"
    #availability_zone = "us-east-1a"
    vpc_security_group_ids = ["sg-0cc6db8ed39b7f31d"]

    root_block_device {
        volume_type = "gp3"
        volume_size= 10
        delete_on_termination = true
        encrypted = false
    }
}