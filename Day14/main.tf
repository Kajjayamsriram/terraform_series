module "networking" {
  source = "./Module/networking"
  vpc_name = "alpha_dev"
  vpc_cidr = "10.0.0.0/22"
  dns = true
  subnets = {
    public1 = {
        az = "us-east-1a"
        ip = true
        cidr = "10.0.0.0/26"
    }
    private1 = {
        az = "us-east-1a"
        ip = false
        cidr = "10.0.1.0/26"
    }
    private2 = {
        az = "us-east-1b"
        ip = false
        cidr = "10.0.1.64/26"
    }
  }
  igw_name = "alpha_dev"
  domain = "vpc"
  eip_name = "alpha_dev"
  nat_name = "alpha_dev"
  av_mode = "regional"
  con_type = "public"
  pub_rt_name = "alpha_pub_dev"
  pvt_rt_name = "alpha_pvt_dev"
}

module "iam" {
    source = "./Module/iam"
    eks_policy = "AmazonEKSClusterPolicy"
    ec2_policy = [
        "AmazonEKSWorkerNodePolicy",
        "AmazonEC2ContainerRegistryPullOnly",
        "AmazonEKS_CNI_Policy"
    ]
}

module "eks" {
  source = "./Module/eks"
  cluster_name = "alpha_dev_cluster"
  cluster_version = 1.35

  node_role = module.iam.ec2_role
  cluster_role = module.iam.eks_role
  sg = module.sg.sg["eks"]
  subnets = [ module.networking.subnets["private1"], module.networking.subnets["private2"] ]

  #launch_template = module.lt.launch_template
  #launch_template_version = module.lt.launch_template_version

  itype = "c7i-flex.large"
  node_group_name = "alpha_dev_nodegroup"
  node_max_size = 3
  node_min_size = 1
  node_max_unavail = 1
  node_desired = 1
  environment = "dev"

  eks_cluster_access = "AmazonEKSClusterAdminPolicy"
  eksadmin_principal_arn = module.iam.eks_admin

  depends_on = [ module.networking, module.sg, module.iam ]
}
module "sg" {
    source  = "./Module/sg"
    vpc_id = module.networking.vpc_id
    security_groups = {
      eks = {
        ingress_rules = [
            {
                port = 0
                protocol = "-1"
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
      ec2 = {
        ingress_rules = [
            {
                port = 80
                protocol= "tcp"
                cidr = "0.0.0.0/0"
            },
            {
                port = 22
                protocol = "tcp"
                cidr = "0.0.0.0/0"
            }
        ]
        egress_rules = [
            {
                port= 0
                protocol = "-1"
                cidr = "0.0.0.0/0"
            }
        ]
      }
    }
    depends_on = [ module.networking ]
}

module "ecr" {
    source = "./Module/ecr"
    repos = {
      alpha_dev_repo = {
        mutability = "MUTABLE"
        encrypt = "AES256"
      } 
    }
}
# module "lt" {
#     source = "./Module/lt"
#     kname = "nasa"
#     lt_name = "alpha_dev_cluster_lt"
#     lt_des = "launch template for eks node group"
#     image_id = "ami-0354c98ae10b02961"
#     itype = "c7i-flex.large"
#     sg = module.sg.sg["eks"]
#     lt_vol_size = 20
#     inst_name = "nodegroup_instances"
# }

module "ec2" {
    source = "./Module/ec2"
    instances = {
      dev_inst ={
        itype = "t3.micro"
        ami = "ami-0e34b50e714a297f1"
        subnet_id = module.networking.subnets["public1"]
        sg = module.sg.sg["ec2"]
        vol_size = 10
        inst_profile = module.iam.inst_profile

      }
    }

    tags = {
        Env = "dev"
        Version = 1.0
    }
    udata = templatefile("${path.module}/eks_script.sh",{
    region = data.aws_region.current.region
    cluster_name = module.eks_cluster.name
    })
    depends_on = [ module.iam, module.networking, module.sg ]
}