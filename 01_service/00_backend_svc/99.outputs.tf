######################################################
//                  Common Data                     //
######################################################

output "project_name" {
  description = "프로젝트 이름"
  value       = module.backend.project_name
}

output "env" {
  description = "VPC 환경 (ex. dev , stg , prd , qa)"
  value       = module.backend.env
}

######################################################
//                     S3 Data                      //
######################################################

output "s3_backend_arn" {
  description = "S3 Backend arn"
  value       = module.backend.s3_backend_arn
}

output "s3_backend_name" {
  description = "S3 Bucket Name(ID)"
  value       = module.backend.s3_backend_name
}

output "s3_backend_region" {
  description = "S3 Bucket Region"
  value       = module.backend.s3_backend_region
}

output "s3_backend_domain" {
  description = "Bucket Region region-specific domain name"
  value       = module.backend.s3_backend_domain
}