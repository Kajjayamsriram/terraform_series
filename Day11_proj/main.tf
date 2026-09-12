module "vpc" {
    source = "./Module/vpc"
    vpc_name = "minapp"
    cidr = "10.0.0.0/22"
    dns = true
    tenancy = "default"
}

module "subnet" {
  source = "./Module/subnet"
  vpc_id = module.vpc.vpc_id
  subnets = {
    public1 = {
        az= "us-east-1a"
        cidr = "10.0.0.0/26"
        ip = true
    }
    public2 = {
        az= "us-east-1b"
        cidr = "10.0.0.64/26"
        ip = true
    }
    private1 = {
        az= "us-east-1a"
        cidr = "10.0.1.0/26"
        ip = false
    }
    private2 = {
        az= "us-east-1b"
        cidr = "10.0.1.64/26"
        ip = false
    }
    private3 = {
        az= "us-east-1a"
        cidr = "10.0.1.128/26"
        ip = false
    }
    private4 = {
        az= "us-east-1b"
        cidr = "10.0.1.192/26"
        ip = false
    }
  }
  depends_on = [ module.vpc ]
}

module "eip" {
    source = "./Module/eip"
    eip_name = "dev_eip"
    depends_on = [ module.subnet ]
}
module "igw" {
    source = "./Module/igw"
    igw_name = "dev_igw"
    vpc_id = module.vpc.vpc_id
    depends_on = [ module.subnet ]
}
module "nat" {
    source = "./Module/nat"
    vpc_id = module.vpc.vpc_id
    alloc_id = module.eip.eip
    az_mode = "regional"
    con_type = "public"
    nat_name = "dev_nat"
    depends_on = [ module.igw ]
}

module "rt" {
    source = "./Module/rt"
    pub_rt_name = "public_rt"
    pvt_rt_name = "private_rt"
    vpc_id = module.vpc.vpc_id
    subnets = module.subnet.subnets
    nat = module.nat.nat
    igw =  module.igw.igw
    
    cidr_pub = "0.0.0.0/0"
    cidr_pvt = "0.0.0.0/0"
    depends_on = [ module.igw, module.nat ]
}
module "key" {
    source = "./Module/key"
    key_name = "dev_key"
    depends_on = [ module.subnet ]
}
module "sg" {
    source = "./Module/sg"
    vpc_id = module.vpc.vpc_id
    sg = {
        lb = {
            description = "LB security group"
        }
        app = {
            description = "APP security group"
        }
        db = {
            description = "DB security group"
        }
    }
    in_rule = {
        lb = {
            sg = "lb"
            port = 80
            protocol = "tcp"
        }
        app = {
            sg = "app"
            source_sg = "lb"
            port = 80
            protocol = "tcp"
        }
        db = {
            sg = "db"
            source_sg = "app"
            port = 3306
            protocol = "tcp"
        }
    }
    e_rule = {
        lb = {
            sg = "lb"
            port = 80
            protocol = "tcp"
        }
        app = {
            sg = "app"
            port = 0
            protocol = "-1"
        }
        db = {
            sg = "db"
            port = 0
            protocol = "-1"
        }
    }
    depends_on = [ module.subnet ]
}
module "lt" {
    source = "./Module/lt"
    lt_name = "bllod_lt"
    inst_name = "test_servers"
    lt_des = "This is a demo lt"
    image_id = "ami-0b6d9d3d33ba97d99" #ubuntu
    sg = module.sg.sg["app"]
    key = "dev_key"
    inst_vol = 11
    itype = "t3.micro"
    
    user_data = base64encode(<<-EOF
    #!/bin/bash
    DB_HOST="${module.db.db_endpoint}"
    DB_NAME="${module.db.db_name}"
    DB_PORT="${module.db.db_port}"
    DB_USER="${module.db.usr_name}"
    DB_PASS="${module.db.db_pass}"

    sudo apt-get update -y
    sudo apt-get install apache2 php libapache2-mod-php php-mysql php-curl php-gd php-json php-zip php-mbstring git -y
    sudo apt-get install mysql-server -y
    sudo systemctl start mysql-server
    sudo systemctl restart apache2
    sudo systemctl enable apache2

    mkdir -p /tmp/test/
    git clone -b master https://github.com/Kajjayamsriram/bloodbank_terraform.git /tmp/test/
    cd /tmp/test
    sed -i "s/mysqldb/$DB_HOST/g" \
        find-donor.php \
        config.php \
        deletedata.php \
        donate-blood.php \
        search.php \
        signup.php
    cp -r /tmp/test/* /var/www/html/
    sleep 30

    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<SQL

    CREATE TABLE IF NOT EXISTS donors (
        id INT AUTO_INCREMENT PRIMARY KEY,
        fname VARCHAR(255) NOT NULL,
        lname VARCHAR(255) NOT NULL,
        mobileno BIGINT UNIQUE,
        city VARCHAR(255) NOT NULL,
        bfrom DATE,
        bto DATE,
        dob DATE,
        bloodgroup VARCHAR(255) NOT NULL
    );

    INSERT INTO donors
    (fname, lname, mobileno, city, bfrom, bto, dob, bloodgroup)
    VALUES
    ('sriram', 'kjm', '8097979700', 'Vij',
    '2025-09-28', '2026-08-28', '1999-01-01', 'O_Positive');

    CREATE TABLE IF NOT EXISTS users (
        username VARCHAR(80) NOT NULL,
        name VARCHAR(80) NOT NULL,
        password VARCHAR(80) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

    INSERT INTO users
    (username, name, password)
    VALUES
    ('sriram', 'sriram kjm', '223344');

    SQL
    
    EOF
    )
    depends_on = [ module.sg, module.db ]
}
module "lb" {
    source = "./Module/alb"
      lb_name = "demolb"
      subnets = [ module.subnet.subnets["public1"].id, module.subnet.subnets["public2"].id ]
      internal = true
      vpc_id = module.vpc.vpc_id
      sg = [ module.sg.sg["lb"]]
    depends_on = [ module.sg, module.subnet ]
}
module "sns"{
    source = "./Module/sns"
    sns_name = "demo_sns"
}
module "asg"{
    source ="./Module/asg"
    asg_name = "demo_asg"
    lt = module.lt.lt
    subnets = [module.subnet.subnets["private1"].id, module.subnet.subnets["private2"].id ]
    tg = [module.lb.tg]
    policy_name = "asg_cpu_scaling"
    policy_type = "TargetTrackingScaling"
    min= 1
    max= 4
    desired = 1
    target_value = 60
    sns = module.sns.sns
    depends_on = [ module.lt, module.subnet, module.lb, module.sns ]
}
module "db" {
    source = "./Module/db"
    iden_name = "devmysqldb"
    eng = "mysql"
    eng_ver = "8.4.9"
    iclass = "db.t4g.micro"
    storage = 20
    max_storage = 30
    db_port = 3306

    db_name = "customers"
    usr_name = "admin"
    pass = "admin123"

    subnets = [ module.subnet.subnets["private3"].id, module.subnet.subnets["private4"].id]
    sg = [module.sg.sg["db"]]
    depends_on = [ module.lb ]
}