module "backend" {
  source = "../../00_module/00.backend"

  project_name          = var.project_name
  env                   = var.env
  input_tags            = var.input_tags
  aws_region            = var.aws_region

  create_backend        = var.create_backend
  s3_backend_name       = var.s3_backend_name
  s3_backend_versioning = var.s3_backend_versioning
  s3_backend_controls   = var.s3_backend_controls

  dynamodb_backend_name = var.dynamodb_backend_name
}