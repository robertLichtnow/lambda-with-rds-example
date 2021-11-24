resource "random_pet" "lambda_bucket_name" {
  prefix = "lambda-with-rds-example"
  length = 4
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = random_pet.lambda_bucket_name.id

  acl           = "private"
  force_destroy = true
}