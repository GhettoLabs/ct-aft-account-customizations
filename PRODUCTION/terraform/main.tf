

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  # version = "2.6.0"

  name                     = "${local.owner}-vpc"
  cidr                     = local.cidr_block
  azs                      = local.azs 
  private_subnets          = local.private_subnet_cidrs
  public_subnets           = local.public_subnet_cidrs
  enable_nat_gateway       = true
  single_nat_gateway       = true
  enable_dns_hostnames     = true
  enable_dns_support       = true
  #enable_s3_endpoint       = true
  #enable_dynamodb_endpoint = true


  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

