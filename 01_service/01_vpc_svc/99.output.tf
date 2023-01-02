######################################################
//                  Common Info                     //
######################################################

output "project_name" {
  description = "프로젝트 이름"
  value       = module.vpc.project_name
}

output "env" {
  description = "VPC 환경 (ex. dev , stg , prd , qa)"
  value       = module.vpc.env
}

output "aws_region" {
  value  = module.vpc.aws_region
}

######################################################
//                   VPC Info                       //
######################################################

output "vpc_cidr" {
  description = "VPC CIDR Block. (ex. 10.0.0.0/16)"
  value       = module.vpc.vpc_cidr
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}


######################################################
//                 Subnet Info                      //
######################################################

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_az" {
  description = "Public Subnet AZ"
  value       = module.vpc.public_subnet_az
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "private_subnet_az" {
  description = "Private Subnet AZ"
  value       = module.vpc.private_subnet_az
}

output "db_subnet_ids" {
  description = "DB Subnet IDs"
  value       = module.vpc.db_subnet_ids
}

output "db_subnet_az" {
  description = "DB Subnet AZ"
  value       = module.vpc.db_subnet_az
}

######################################################
//              Route Table Info                    //
######################################################

output "public_rtb_id" {
  description = "Public Route Table ID"
  value       = module.vpc.public_rtb_id
}

output "private_rtb_id" {
  description = "Private Route Table ID"
  value       = module.vpc.private_rtb_id
}

output "db_rtb_id" {
  description = "DB Route Table ID"
  value       = module.vpc.db_rtb_id
}