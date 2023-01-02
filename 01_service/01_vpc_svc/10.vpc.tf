module "vpc" {
  source = "../../00_module/01.vpc"

  project_name = var.project_name
  env          = var.env
  input_tags   = var.input_tags
  aws_region   = var.aws_region

  // VPC
  vpc_cidr          = var.vpc_cidr
  create_vpc        = var.create_vpc
  vpc_id            = var.vpc_id
  create_nat        = var.create_nat

  // Subnet
  create_pub_subnet = var.create_pub_subnet
  pub_sub_cidr      = var.pub_sub_cidr

  create_pri_subnet = var.create_pri_subnet
  pri_sub_cidr      = var.pri_sub_cidr

  create_db_subnet  = var.create_db_subnet
  db_sub_cidr       = var.db_sub_cidr
}