######################################################
//                Common Variables                  //
######################################################

variable "project_name" {
  description = "프로젝트 이름"
}

variable "env" {
  description = "VPC 환경 ( ex. dev , stg , prd , qa )"
}

variable "input_tags" {
  description = "모든 리소스에 넣을 Tag 입력, ( 기본 : 'Environment' , 'System' )"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "배포할 Region"
  type        = string
}

######################################################
//                  S3 Variables                    //
######################################################

variable "create_backend" {
  description = "S3 & DynamoDB 생성 유무 ( true: 생성 , false: 미생성 )"
  type        = bool
}

variable "s3_backend_name" {
  description = "백엔드 S3 Bucket 이름"
  type        = string
}

variable "s3_backend_versioning" {
  description = "S3 Bucket Versioning 유무 ( Enabled , Disabled )"
  type        = string
}

variable "s3_backend_controls" {
  description = "S3 Bucket ACL 소유권 ( BucketOwnerPreferred , ObjectWriter )"
  type        = string
}

######################################################
//              DynamoDB Variables                  //
######################################################

variable "dynamodb_backend_name" {
  description = "DynamoDB Name"
  type        = string
}