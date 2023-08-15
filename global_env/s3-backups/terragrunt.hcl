terraform {
  source = "git@github.com:GiladTrachtenberg/medium-tf-modules.git//s3?ref=s3-v0.0.1"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  env = include.env.locals.env
  bucket_name = "example-backups"
  lambda_arn = dependency.lambda.outputs.lambda_arn
}

dependency "lambda" {
  config_path = "../lambda"

  mock_outputs = {
    lambda_arn = "example-hello"
  }
}