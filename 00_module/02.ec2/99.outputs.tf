######################################################
//                  Common Info                     //
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
//                   EC2 Info                       //
######################################################

output "bastion_id" {
  description = "Bastion Host Information"
  value       = aws_instance.bastion.*.id
}

output "bastion_eip" {
  description = "Bastion Host Public IP"
  value       = aws_instance.bastion.*.public_ip
}

output "bastion_pip" {
  description = "Bastion Host Private IP"
  value       = aws_instance.bastion.*.private_ip
}

output "alb_dns" {
  description = "ALB Information"
  value       = aws_lb.alb_web.*.dns_name
}