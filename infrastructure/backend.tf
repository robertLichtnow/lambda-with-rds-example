terraform {
  backend "remote" {
    organization = "lambda-with-rds-example"

    workspaces {
      name = "prod"
    }
  }
}