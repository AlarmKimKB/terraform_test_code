######################################################
//                  Common Info                     //
######################################################

output "project_name" {
  description = "프로젝트 이름"
  value       = module.web.project_name
}

output "env" {
  description = "VPC 환경 (ex. dev , stg , prd , qa)"
  value       = module.web.env
}

######################################################
//                   EC2 Info                       //
######################################################

output "bastion_id" {
  description = "Bastion Host ID"
  value       = module.web.bastion_id
}

output "bastion_eip" {
  description = "Bastion Host Public IP"
  value       = module.web.bastion_eip
}

output "bastion_pip" {
  description = "Bastion Host Private IP"
  value       = module.web.bastion_pip
}

output "alb_dns" {
  description = "ALB Domain"
  value       = module.web.alb_dns
}