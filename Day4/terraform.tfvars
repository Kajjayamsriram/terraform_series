# sg variables
ingress_ports = [22, 80, 443, 8080]
name = "tf-sg"
description = "Test security group for terraform"

# ec2 instance variables
ami_id = "ami-004f790b835b26145"
itype = "c7i-flex.large"
kname = "Luffy-kp"
zone = "us-east-1a"
size = 10

#s3 bucket variables
bucket_name = "tbucket.random.18907"