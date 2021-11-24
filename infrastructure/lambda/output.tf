output "app_function_name" {
  description = "Name of the Lambda function."

  value = aws_lambda_function.app.function_name
}

output "invoke_arn" {
  description = "Invoke ARN for api gw."

  value = aws_lambda_function.app.invoke_arn
}

output "distributable_path" {
  value = data.archive_file.lambda_dist.output_path
}