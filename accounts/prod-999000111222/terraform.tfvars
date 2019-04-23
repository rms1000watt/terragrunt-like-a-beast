terragrunt {
  iam_role                 = "arn:aws:iam::999000111222:role/prod-us-west-2"
  TERRAGRUNT_SOURCE_UPDATE = true

  remote_state = {
    backend = "s3"

    config {
      key            = "${path_relative_to_include()}/terraform.tfstate"
      bucket         = "pizza-terraform-999000111222-prod"
      region         = "us-west-2"
      dynamodb_table = "terraform-locks"
      encrypt        = true
    }
  }

  terraform {
    required_version = "0.11.13"

    before_hook "get_defaults" {
      commands = ["init", "${get_terraform_commands_that_need_vars()}", "init-from-module"]
      execute  = ["cp", "${get_parent_tfvars_dir()}/default.tf", "."]
    }

    before_hook "get_environment" {
      commands = ["init", "${get_terraform_commands_that_need_vars()}"]
      execute  = ["cp", "${get_parent_tfvars_dir()}/environment.tf", "."]
    }

    extra_arguments "parallelize" {
      commands  = ["${get_terraform_commands_that_need_vars()}"]
      arguments = ["-parallelism=1000"]
    }

    extra_arguments "always_local_plan" {
      commands  = ["plan"]
      arguments = ["-out=./saved-plan"]
    }

    extra_arguments "force_saved_plan" {
      commands  = ["apply"]
      arguments = ["./saved-plan"]
    }
  }
}
