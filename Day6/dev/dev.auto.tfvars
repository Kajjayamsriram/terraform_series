tags = {
    Name = "web-server"
}
amitest = "ami-004f790b835b26145"
instance_type = "t3.micro"
key_name = "Luffy-kp"
availability_zone = "us-east-1b"
volume_size = 11

#sg values
name = "app-sg"
description = "demo app security group"
ingress_values = [
{
    port  = 80
    protocol = "tcp"
    cidrs = ["0.0.0.0/0"]
},
{
    port  = 22
    protocol = "tcp"
    cidrs = ["0.0.0.0/0"]
}
]
egress_values = [{
    port  = 0
    protocol = "-1"
    cidrs = ["0.0.0.0/0"]
}
]

#bucket values
bucket = "demoappbucket7890"