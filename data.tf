data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_availability_zones" "azs" {
  all_availability_zones = true

  filter {
    name   = "opt-in-status"
    values = ["not-opted-in", "opted-in"]
  }
}
