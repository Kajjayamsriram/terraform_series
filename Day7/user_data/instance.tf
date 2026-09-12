module "inst1" {
    source= "./module"
    tags = var.tags
    ami_id = var.ami_id
    itype = var.itype
    zone = var.zone
    kname = var.kname
    size = var.size
    # environment = var.env
    # db_endpoint = var.db_conn
}