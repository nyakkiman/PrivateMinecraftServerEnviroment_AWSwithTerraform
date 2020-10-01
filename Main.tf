terraform {
  backend "s3" {
    bucket = "aomaru-terraform-practice"
    key    = "aws-backup"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  version = "~> 3.0"
  region  = "us-east-1"
}

