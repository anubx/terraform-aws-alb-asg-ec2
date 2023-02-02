data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "azs" {
#   all_availability_zones = true

  filter {
    name   = "opt-in-status"
    values = ["opted-in"]
  }
}

data "aws_ami" "amazon2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


