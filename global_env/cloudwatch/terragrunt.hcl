terraform {
  source = "git@github.com:GiladTrachtenberg/medium-tf-modules.git//cloudwatch?ref=cloudwatch-v0.0.1"
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
  backups_topic_name = dependency.sns.outputs.sns_topic_name
}

dependency "sns" {
  config_path = "../sns"

  mock_outputs = {
    sns_topic_name = "example-hello"
  }
}