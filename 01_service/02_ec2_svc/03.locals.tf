locals {
  project_name = data.terraform_remote_state.vpc.outputs.project_name
  env          = data.terraform_remote_state.vpc.outputs.env
  aws_region   = data.terraform_remote_state.vpc.outputs.aws_region
}