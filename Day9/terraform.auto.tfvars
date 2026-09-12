tenancy = "default"
vpc_name = "mivi_block"
vpc_cidr = "10.0.0.0/16"
dns = true

subnet = {
    public1 = {
        subnet_cidr = "10.0.0.0/24"
        az = "us-east-1a"
        pub_ip = true
    }
    public2 = {
        subnet_cidr = "10.0.1.0/24"
        az = "us-east-1b"
        pub_ip = true
    }
    private1 = {
        subnet_cidr = "10.0.2.0/24"
        az = "us-east-1a"
        pub_ip = false
    }
    private2 = {
        subnet_cidr = "10.0.3.0/24"
        az = "us-east-1b"
        pub_ip = false
    }
}

igw_name = "mivi_inter"

nat_name = "mivi_nat"
av_mode = "regional"
con_type = "public"
pub_rt_name = "mivi_pub_rt"
pvt_rt_name = "mivi_pvt_rt"

kname = "mivi_key"

sg_name = "mivi_sg"
sg_des = "This is a mivi test dev group"
ingress_values  = [
    {
        port = 22
        protocol= "tcp"
        cidr = ["0.0.0.0/0"]
    },
    {
        port = 80
        protocol= "tcp"
        cidr = ["0.0.0.0/0"]
    }
]
egress_values = [
    {
        port = 0
        protocol = "-1"
        cidr = ["0.0.0.0/0"]
    }
]

eip_name = "mivi_ip"

ec2_i = {
    mivi_serv = {
        itype = "t3.micro"
        vol_size = 10
        ami_id = "ami-0332d564d76dbd8d6"
        subnet_name = "public1"
    }
    mivi_pvt = {
        itype = "t3.micro"
        vol_size = 10
        ami_id = "ami-0332d564d76dbd8d6"
        subnet_name = "private1"
    }
}
