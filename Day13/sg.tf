data "aws_vpc" "vpc_default"{
    default = true
}
data "aws_security_group" "demo_sg" {
    name = "demo_sg"
}

resource "aws_security_group" "efs" {
    tags = {
      Name = "efs-sg"
    }
    vpc_id = data.aws_vpc.vpc_default.id
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [data.aws_security_group.demo_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}