variable app_name {
    default = "demo"
}

variable "alb_enable_access_logs" {
  type    = bool
  default = false
}

variable "alb_access_logs_bucket_name" {
  type    = string
  default = null
}

variable "alb_access_logs_s3_prefix" {
  type    = bool
  default = null
}

variable cidr {
    default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = []
}

variable "public_subnets" {
  type    = list(any)
  default = []
}
