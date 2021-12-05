
# --- root/main.tf ---

module "s3" {
  source = "./s3"

  aws_region_in = var.aws_region
}

module "lambda" {
  source = "./lambda"

  aws_region_in        = var.aws_region
  aws_lambda_bucket_in = module.s3.lambda_bucket_name
}

module "api_gw" {
  source = "./api_gw"

  aws_region_in               = var.aws_region
  aws_lambda_integration_in   = module.lambda.invoke_arn
  aws_lambda_function_name_in = module.lambda.app_function_name
}

module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  security_groups  = local.security_groups
  private_sn_count = 3
  max_subnets      = 20
  private_cidrs    = [for i in range(1, 255) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}