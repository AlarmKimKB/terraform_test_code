######################################################
//                  Common Data                     //
######################################################

output "project_name" {
  description = "프로젝트 이름"
  value       = var.project_name
}

output "env" {
  description = "VPC 환경 (ex. dev , stg , prd , qa)"
  value       = var.env
}

######################################################
//                     S3 Data                      //
######################################################

output "s3_backend_arn" {
  description = "S3 Backend arn"
  value       = var.create_backend ? join("", aws_s3_bucket.s3_backend.*.arn) : ""
}

output "s3_backend_name" {
  description = "S3 Bucket Name(ID)"
  value       = var.create_backend ? join("", aws_s3_bucket.s3_backend.*.id) : ""
}

output "s3_backend_region" {
  description = "S3 Bucket Region"
  value       = var.create_backend ? join("", aws_s3_bucket.s3_backend.*.region) : ""
}

output "s3_backend_domain" {
  description = "Bucket Region region-specific domain name"
  value       = var.create_backend ? join("", aws_s3_bucket.s3_backend.*.bucket_regional_domain_name) : ""
}