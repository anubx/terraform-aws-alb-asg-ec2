module "vpc" {
  # source = "../../"
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "${local.name_prefix}-vpc"
  cidr = var.cidr

  azs             = local.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true

  enable_ipv6 = false

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = "${local.name_prefix}-public"
  }

  private_subnet_tags = {
    Name = "${local.name_prefix}-private"
  }

  tags = {
    Owner       = "Terraform"
    Environment = local.env
  }

  vpc_tags = {
    Name = "${local.name_prefix}-vpc"
  }
}