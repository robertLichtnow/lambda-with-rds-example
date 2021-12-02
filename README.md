# Summary
Still a work in progress.

This repository is a sample with terraform + typescript on how to create a lambda function that receives HTTP requests from an API Gateway and connects safely with a database created with RDS and safely keeps its connection alive between function calls.

This repository does not worry about secrets privacy, since it doesn't version the terraform state.

This project does not use RDS Proxy, even though it is a great alternative for managing the connection pool for larger applications.

## What has been done already
- Terraform creation of the following resources
  - API Gateway
  - Lambda function
  - S3 bucket to store the code of the function
- Automated build and deployment of lambda function on each `terraform apply`
-

## What still needs to be done
- Manage VPC + private subnets for RDS
- The RDS instance itself
- Lambda environment variables (needed for database access)
  - Create credentials during `terraform apply` with random string
- Run migrations when lambda is deployed
- Create seed data for one table
- Create API to retrieve given seed data

# How to use

## Requirements
- `node v12+`
- `yarn`
- `terraform`
- `A configured AWS profile with admin access`

## Deploying

```bash
$ terraform apply --auto-approve
```

## Consuming API
With the `terraform apply`, you'll get the `invoke url` output. Use that `url` to consume the API with

```bash
$ curl <invoke_url>/api/health
```
It should output `OK`