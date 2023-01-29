locals {
  env    = terraform.workspace
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  azs = data.azs.names
  name_prefix = var.name_prefix

  counts = {
  "development"     = "1"
  "integration"     = "1"
  "testing"     = "1"
  "staging" = "1"
  "production"    = "2"
  }

  container_cpus = {
    "development"     = "256"
    "integration" = "256"
    "testing" = "256"
    "staging" = "256"
    "production"    = "4096"
    }

  container_mems = {
    "development"     = "512"
    "integration" = "512"
    "testing" = "512"
    "staging" = "512"
    "production"    = "8192"
    }

  container_cpu = lookup(local.container_cpus, local.env)
  container_mem = lookup(local.container_mems, local.env)
  count = lookup(local.counts, local.env)

  volume_name = data.aws_ssm_parameter.volume_name
  volume_id = data.aws_ssm_parameter.volume_id
  access_id = data.aws_ssm_parameter.access_id
  efs_arn = data.aws_ssm_parameter.efs_arn

  tags = {
    team     = "devops"
    solution = "${var.name_prefix}-${local.env}"
  }
}