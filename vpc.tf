module "vpc" {
  # source = "../../"
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"

  name = "ec-${var.name}-vpc"
  cidr = var.cidr

  azs             = ["${local.azs}"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = "demo-${var.name}-public"
  }

  private_subnet_tags = {
    Name = "demo-${var.name}-private"
  }

  tags = {
    Owner       = "Terraform"
    Environment = var.name
  }

  vpc_tags = {
    Name = "demo-${var.name}-vpc"
  }
}