terraform {
  backend "s3" {}
}

provider "aws" {
  max_retries            = "5"
  profile                = "pizza-iam-manager"
  region                 = "us-west-2"
  skip_get_ec2_platforms = true
  skip_region_validation = true
}
