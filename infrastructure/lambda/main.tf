# --- lambda/main.tf ---

data "archive_file" "lambda_dist" {
  type = "zip"

  source_dir  = "${path.root}/../dist"
  output_path = "${path.root}/lambda/dist.zip"
}

resource "aws_s3_bucket_object" "lambda_app" {
  bucket = var.aws_lambda_bucket_in

  key    = "dist.zip"
  source = data.archive_file.lambda_dist.output_path

  etag = data.archive_file.lambda_dist.output_md5

  depends_on = [
    data.archive_file.lambda_dist
  ]
}

resource "aws_lambda_function" "app" {
  function_name = "App"

  s3_bucket = var.aws_lambda_bucket_in
  s3_key    = aws_s3_bucket_object.lambda_app.key

  runtime = "nodejs12.x"
  handler = "src/shared/infrastructure/lambda/index.handler"

  source_code_hash = data.archive_file.lambda_dist.output_base64sha256

  role = aws_iam_role.lambda_exec.arn
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = {
      NODE_ENV = "production"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "/aws/lambda/${aws_lambda_function.app.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
