variable "ssh_key_name" {
  default = "dev"
}

variable "tf_remote_state_s3_bucket_global_region" {
  default = "us-west-2"
}

variable "tf_remote_state_s3_bucket_global_profile_name" {
  default = "dev"
}

variable "vpc_region" {
  default = "us-west-2"
}

variable "environment" {
  default = "dev"
}

variable "vpc_name" {
  default = "dev-vpc"
}

variable "aws_provider_profile_name" {
  default = "pizza-iam-manager"
}

variable "tf_remote_state_s3_bucket_prefix" {
  default = "pizza-terraform"
}

variable "tf_remote_state_s3_bucket_current_environment_region" {
  default = "us-west-2"
}

variable "dns_zone_name" {
  default = "dev.uswest2.pizza.com"
}
