output "lambda_bucket_name" {
  value       = module.s3.lambda_bucket_name
  description = "The name of the lambda bucket."
}

output "lambda_function_name" {
  value       = module.lambda.app_function_name
  description = "The name of the lambda function."
}

output "lambda_invoke_arn" {
  value       = module.lambda.invoke_arn
  description = "The Invoke ARN for the lambda function."
}

output "base_url" {
  value = module.api_gw.base_url
}

output "distributable_path" {
  value = module.lambda.distributable_path
}