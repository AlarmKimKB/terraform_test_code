######################################################
//                  Provider Set                    //
######################################################

provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = "~> 1.3.4" # 1.3.4 버전 이상만 사용.

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.29.0"
    }
  }

  backend "s3" {
    bucket = "{S3-Backend}"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}