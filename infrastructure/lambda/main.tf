
resource "null_resource" "build_lambda_app" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "cd ${path.cwd}/.. && yarn build"
  }
}

data "archive_file" "lambda_dist" {
  type = "zip"

  source_dir  = "${path.cwd}/../dist"
  output_path = "${path.cwd}/lambda/dist.zip"

  depends_on = [
    null_resource.build_lambda_app
  ]
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

resource "aws_cloudwatch_log_group" "app" {
  name = "/aws/lambda/${aws_lambda_function.app.function_name}"

  retention_in_days = 30
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}