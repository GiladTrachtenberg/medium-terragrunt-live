remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        profile = "example-terraform"
        role_arn = "<ARN>"
        bucket = "example-terraform-state"

        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "eu-central-1"
        encrypt = true
        dynamodb_table = "example-terraform-state-lock-table"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
provider "aws" {
    region = "eu-central-1"
    profile = "example-terraform"

    assume_role {
        session_name = "example-s3-backups"
        role_arn = "<ARN>"
    }
}
EOF
}