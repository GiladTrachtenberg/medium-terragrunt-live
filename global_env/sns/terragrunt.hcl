terraform {
  source = "git@github.com:GiladTrachtenberg/medium-tf-modules.git//sns?ref=sns-v0.0.1"
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
  backups_topic_name = "example-backups-alarm-topic"
  email_addresses = ["<ADDRESS>"]
}