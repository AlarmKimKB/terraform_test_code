data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.s3_backend_vpc.bucket
    key    = var.s3_backend_vpc.key
    region = var.s3_backend_vpc.region
  }
}