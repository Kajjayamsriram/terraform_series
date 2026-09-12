resource "aws_db_subnet_group" "mysql_subnet" {
    name = "mysql_subnet_group"
    subnet_ids = var.subnets
}

resource "aws_db_instance" "mysql_db" {
    identifier = var.iden_name #customers
    engine = var.eng #mysql
    engine_version  = var.eng_ver #8.0
    instance_class = var.iclass #db.t4g.micro

    allocated_storage = var.storage #20
    max_allocated_storage = var.max_storage #25
    storage_type = "gp3"

    db_name = var.db_name
    username  = var.usr_name #"root"
    password  = var.pass #"admin123"

    port =var.db_port
    db_subnet_group_name = aws_db_subnet_group.mysql_subnet.name
    vpc_security_group_ids = var.sg

    publicly_accessible = false
    multi_az = false
    #backup_retention_period = 7
    #backup_window = "03:00-04:00"
    #maintenance_window = "sun:04:00-sun:05:00"
    auto_minor_version_upgrade = false
    storage_encrypted = true
    deletion_protection = false
    skip_final_snapshot  = true
    #final_snapshot_identifier = "demo_mysql_db"

    copy_tags_to_snapshot = false
    tags= {
        Name = "demo_mysql_miniapp"
    }
}