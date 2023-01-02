module "web" {
  source = "../../00_module/02.ec2"

  project_name            = local.project_name
  env                     = local.env
  input_tags              = var.input_tags
  aws_region              = local.aws_region

  s3_backend_vpc          = var.s3_backend_vpc

  create_bastion          = var.create_bastion
  bastion_type            = var.bastion_type
  keypair_name            = var.keypair_name
  sg_bastion_inbound_rule = var.sg_bastion_inbound_rule

  create_web              = var.create_web
  web_type                = var.web_type
  web_ebs                 = var.web_ebs
  web_autoscaling_config  = var.web_autoscaling_config
}