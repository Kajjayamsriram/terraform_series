module "network" {
  source = "../../Module/networking"
  vpc_name = "beta-dev-vpc"
  vpc_cidr = "10.0.0.0/22"
  dns = true
  subnets = {
    public1 = {
        cidr = "10.0.0.0/26"
        az= "us-east-1a"
        ip = true
    }
    public2 = {
        cidr = "10.0.0.64/26"
        az= "us-east-1b"
        ip = true
    }
    private1 = {
        cidr = "10.0.1.0/26"
        az= "us-east-1a"
        ip = false
    }
    private2 = {
        cidr = "10.0.1.64/26"
        az= "us-east-1b"
        ip = false
    }
  }
  igw_name = "beta-dev-igw"
  domain = "vpc"
  eip_name = "beta-dev-eip"
  nat_name = "beta-dev-nat"
  av_mode = "regional"
  con_type = "public"
  pub_rt_name = "beta-dev-pub-rt"
  pvt_rt_name = "beta-dev-pvt-rt"
}
module "sg" {
  source = "../../Module/sg"
  vpc_id = module.network.vpc_id
  security_groups = {
    lb = {
        ingress_rules = [
            {
                port = 80
                protocol = "tcp"
                cidr = "0.0.0.0/0"
            }   
        ]
        egress_rules = [
            {
                port = 0
                protocol = "-1"
                cidr = "0.0.0.0/0"
            }
        ]
    },
    ecs = {
        ingress_rules = [
            {
                port = 80
                protocol = "tcp"
                cidr = "0.0.0.0/0"
            }
        ]
        egress_rules = [
            {
                port = 0
                protocol = "-1"
                cidr = "0.0.0.0/0"
            }
        ]
    }
  }
  depends_on = [ module.network ]
}

module "lb"{
    source = "../../Module/lb"
    project = "beta"
    env = "dev"
    vpc_id = module.network.vpc_id
    internal = false
    load_balancer_type = "application"
    subnets = [ module.network.subnets["public1"], module.network.subnets["public2"] ]
    sg = [ module.sg.sg["lb"] ]
    depends_on = [ module.network, module.sg ]
}

module "iam" {
    source = "../../Module/iam"
    ecs_role_name = "ecsTaskExectionRole"
    ecs_policy = "AmazonECSTaskExecutionRolePolicy"
    ecs_role_json = file("${path.module}/templates/ecs_role.json")
}

module "cloudwatch" {
  source = "../../Module/cloudwatch"
  project = "beta"
  env = "dev"
  retention = 7
  tags = {
    Env = "dev"
    CostCenter = "beta-app"
  }
}

module "ecs" {
  source = "../../Module/ecs"
  proj = "beta"
  env = "dev"
  tags = {
    Env = "dev"
    CostCenter = "beta-app"
  }
  compatibility = "FARGATE"
  network_mode = "awsvpc"
  cpu = 256 #0.25 vCPU
  memory = 512 #512 MiB
  ecs_role = module.iam.ecs_role

  cont_def = templatefile("${path.module}/templates/task_def.json", {
    ecr_repo = "967848863323.dkr.ecr.us-east-1.amazonaws.com",
    image = "testimage",
    image_tag = "latest",
    cloudwatch_group = module.cloudwatch.log_group_name
    region = data.aws_region.this.region
    cont_name = "nginx"
  })

  launch_type = "FARGATE"
  desired_count = 2
  subnets = [ module.network.subnets["private1"], module.network.subnets["private2"] ]
  sg = module.sg.sg["ecs"]

  lb_tg = module.lb.tg_arn
  cont_name = "nginx"
  cont_port = 80
  depends_on = [ module.network, module.cloudwatch, module.iam, module.lb, module.sg ]
}