terraform {
  source = "git@github.com:GiladTrachtenberg/medium-tf-modules.git//lambda?ref=lambda-v0.0.1"
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
  codefile_name = "example-s3backups"
  zipfile_name = "example-s3backups"
  role_name = dependency.iam.outputs.role_name
  function_name = "example-s3-daily-validation"
}

dependency "iam" {
  config_path = "../iam"

  mock_outputs = {
    role_name = "example-hello"
  }
}