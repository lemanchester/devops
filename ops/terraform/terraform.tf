# VPC
module "vpc" {
  source = "./modules/vpc"

  env      = var.env
  vpc_cidr = var.vpc_cidr
  region   = var.region
  azs      = var.azs

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.env}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.env}" = "shared"
  }

  vpc_tags = {
    "kubernetes.io/cluster/${var.env}" = "shared"
  }
}

# Docker Repository
resource "aws_ecr_repository" "webapp" {
  name = "webapp"
}

# AWS key
resource "aws_key_pair" "admin" {
  key_name   = var.key_pair_name
  public_key = var.key_pair_public_key
}

# Kubernetes
module "eks" {
  source = "./modules/eks"
  env = var.env
  cluster_name = var.env
  subnets = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      instance_type = "m5.xlarge"
      asg_max_size = 5
      key_name = aws_key_pair.admin.key_name
      root_volume_size = 20
      spot_price = "0.113"
      spot_max_price = "0.188"
    },
  ]
  worker_additional_security_group_ids = [module.vpc.sg_eks_workers]
}
