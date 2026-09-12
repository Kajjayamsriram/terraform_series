module "vpc" {
    source = "./module/vpc"
    tenancy = var.tenancy
    vpc_name = var.vpc_name
    cidr_block = var.vpc_cidr
    dns = var.dns
}

module "subnet" {
    source = "./module/subnet"
    subnet = var.subnet
    vpc_id = module.vpc.vpc_id
}

module "igw" {
    source = "./module/igw"
    igw_name = var.igw_name
    vpc_id = module.vpc.vpc_id
}
module "nat" {
    source = "./module/nat"
    nat_name = var.nat_name
    av_mode = var.av_mode
    con_type = var.con_type
    vpc_id = module.vpc.vpc_id
    eip = module.eip.eip_id
}
module "route_table" {
    source = "./module/route_table"
    vpc_id = module.vpc.vpc_id
    pub_rt_name = var.pub_rt_name
    pvt_rt_name = var.pvt_rt_name
    nat_gw = module.nat.nat_gw
    igw = module.igw.igw
    subnet_ids = module.subnet.subnet_ids
}
module "key_pair"{
    source = "./module/key_pair"
    kname = var.kname
}
module "sg"{
    source = "./module/sg"
    sg_name = var.sg_name
    sg_des = var.sg_des
    ingress_values = var.ingress_values
    egress_values = var.egress_values
    vpc_id = module.vpc.vpc_id
}
module "ec2" {
    source = "./module/ec2"
    ec2_inst = var.ec2_i
    subnet_ids = module.subnet.subnet_ids
    kname = module.key_pair.kname
    security_group_id = module.sg.security_group_id

}
module "eip" {
    source = "./module/eip"
    eip_name = var.eip_name
}