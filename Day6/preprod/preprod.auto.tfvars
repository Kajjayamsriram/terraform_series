tags = {
    Name = "preprodserv"
}
ami = "ami-01b91d3cd0dd501ff"
itype = "c7i-flex.large"
zone = "us-west-1a"
kname = "westkey"
size = 11
name = "preprod-sg"
description = "preprod security group"
ingress_values = [
{
    port = 80
    protocol = "tcp"
    cidrs = ["0.0.0.0/0"]
},
{
    port = 22
    protocol = "tcp"
    cidrs = ["0.0.0.0/0"]
}
]
egress_values = [
{
    port = 0
    protocol = "-1"
    cidrs = ["0.0.0.0/0"]
}
]
bucket="preprodemobucket7890"