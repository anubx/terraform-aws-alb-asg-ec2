variable "app_name" {
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

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "custom_tags" {
  description = "Custom tags to set on resources"
  type        = map(string)
  default = {
    "Managed_By"  = "terraform"
    "Team"        = "devops"
    "Application" = "demo-app"
  }
}
