module "s3" {
  source = "./s3"

  aws_region_in = var.aws_region
}

module "lambda" {
  source = "./lambda"

  aws_region_in = var.aws_region
  aws_lambda_bucket_in = module.s3.lambda_bucket_name
}

module "api_gw" {
  source = "./api_gw"

  aws_region_in = var.aws_region
  aws_lambda_integration_in = module.lambda.invoke_arn
  aws_lambda_function_name_in = module.lambda.app_function_name
}