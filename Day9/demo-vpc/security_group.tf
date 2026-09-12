resource "aws_security_group" "sg1" {
    name = "dev-sg"
    description = "Dev security group"
    vpc_id = aws_vpc.vpc1.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    # ingress {
    #     from_port = 8
    #     to_port = 8
    #     protocol = "icmp"
    #     cidr_blocks = ["172.31.0.0/16"]
    #     #echo reply =0, echo request =8
    # }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["172.31.0.0/16"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}