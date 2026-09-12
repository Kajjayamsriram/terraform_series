module "web" {
    source = "../modules/ec2"
    tags = var.tags
    ami_id = var.amitest
    instance_type = var.instance_type
    key_name = var.key_name
    availability_zone = var.availability_zone
    vpc_security_group_ids = [module.sg1.security_group_id]
    volume_size = var.volume_size
    depends_on = [module.sg1, module.s3]
}

module "sg1" {
    source = "../modules/sg"
    name = var.name
    description = var.description
    #vpc_id = data.aws_vpc.vpcid.id #avoiding as declared in module (or) if passed here avoid using data block in module.
    ingress_values = var.ingress_values
    egress_values = var.egress_values
}

module "s3" {
    source = "../modules/s3"
    bucket = var.bucket
}