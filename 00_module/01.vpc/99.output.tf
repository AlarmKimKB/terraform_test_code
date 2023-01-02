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

output "aws_region" {
  value = var.aws_region
}

######################################################
//                   VPC Info                       //
######################################################

output "vpc_cidr" {
  description = "VPC CIDR Block. (ex. 10.0.0.0/16)"
  value       = var.vpc_cidr
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.selected.id
}


######################################################
//                 Subnet Info                      //
######################################################

output "public_subnet_ids" {
  description = "Public Subnet IDs"
  value       = aws_subnet.public_subnets.*.id
}

output "public_subnet_az" {
  description = "Public Subnet AZ"
  value       = aws_subnet.public_subnets.*.availability_zone
}

output "private_subnet_ids" {
  description = "Private Subnet IDs"
  value       = aws_subnet.private_subnets.*.id
}

output "private_subnet_az" {
  description = "Private Subnet AZ"
  value       = aws_subnet.private_subnets.*.availability_zone
}

output "db_subnet_ids" {
  description = "DB Subnet IDs"
  value       = aws_subnet.db_subnets.*.id
}

output "db_subnet_az" {
  description = "DB Subnet AZ"
  value       = aws_subnet.db_subnets.*.availability_zone
}

######################################################
//              Route Table Info                    //
######################################################

output "public_rtb_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public_rtb.*.id
}

output "private_rtb_id" {
  description = "Private Route Table ID"
  value       = aws_route_table.private_rtb.*.id
}

output "db_rtb_id" {
  description = "DB Route Table ID"
  value       = aws_route_table.db_rtb.*.id
}