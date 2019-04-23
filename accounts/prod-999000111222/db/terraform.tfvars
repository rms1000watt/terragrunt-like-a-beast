terragrunt {
  terraform {
    source = "git::git@github.com:rms1000watt/terragrunt-like-a-beast//blueprints/db?ref=db-0.0.1"
  }

  include {
    path = "${find_in_parent_folders()}"
  }
}
