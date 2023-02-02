locals {
  env         = terraform.workspace
  name_prefix = "${var.app_name}-${local.env}"
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  # azs         = data.aws_availability_zones.azs.names
  azs = formatlist("${data.aws_region.current.name}%s", ["a", "b", "c"])
  ami = data.aws_ami.amazon2.id

  counts = {
    "dev" = "1"
    "uat" = "1"
    "prd" = "2"
  }


  count = lookup(local.counts, local.env)

  tags = {
    team     = "devops"
    solution = "${local.name_prefix}"
  }
}