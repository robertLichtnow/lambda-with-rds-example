
# --- root/main.tf ---

module "s3" {
  source = "./s3"

  aws_region_in = var.aws_region
}


module "networking" {
  source           = "./networking"
  vpc_cidr         = local.vpc_cidr
  security_groups  = local.security_groups
  private_sn_count = 3
  max_subnets      = 20
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  db_subnet_group  = true
}

module "database" {
  source                 = "./database"
  db_storage             = 10
  db_engine_version      = "5.7.34"
  db_instance_class      = "db.t2.micro"
  dbname                 = var.dbname
  dbuser                 = var.dbuser
  dbpassword             = var.dbpassword
  db_identifier          = "app-db"
  skip_db_snapshot       = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
}

module "lambda" {
  source = "./lambda"

  aws_lambda_bucket_in = module.s3.lambda_bucket_name
  private_subnet_ids   = module.networking.private_subnet_ids
  security_group_ids   = module.networking.app_security_group
}

module "api_gw" {
  source = "./api_gw"

  aws_lambda_integration_in   = module.lambda.invoke_arn
  aws_lambda_function_name_in = module.lambda.app_function_name
}
