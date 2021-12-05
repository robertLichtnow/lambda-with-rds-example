# --- root/locals.tf ---

locals {
  vpc_cidr = "10.123.0.0/16"
}

locals {
  security_groups = {
    rds = {
      name        = "rds_sg"
      description = "Security Group for RDS Access"
      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
    app = {
      name        = "lambda_sg"
      description = "Security Group for Lambda Access"
      ingress = {
        lambda = {
          from        = 0
          to          = 0
          protocol    = -1
          cidr_blocks = [local.vpc_cidr]
        }
      }
    }
  }
}