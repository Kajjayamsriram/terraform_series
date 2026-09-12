resource "aws_security_group" "sg1" {
    tags = {
        Name = "demo_sg1"
    }
    description = "demo security group for Launch Template"
    vpc_id = aws_vpc.vpc1.id
    ingress {
        from_port = 22
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}