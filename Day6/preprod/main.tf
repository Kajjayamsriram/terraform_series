module "web" {
    source = "../modules/ec2"
    tags = var.tags
    ami_id = var.ami
    instance_type = var.itype
    availability_zone = var.zone
    vpc_security_group_ids = [module.sg1.security_group_id]
    key_name = var.kname
    volume_size = var.size
    depends_on = [ module.sg1, module.s3 ]
}

module "sg1"{
    source = "../modules/sg"
    name = var.name
    description = var.description
    ingress_values = var.ingress_values
    egress_values = var.egress_values
}

module "s3" {
    source = "../modules/s3"
    bucket=var.bucket
}
