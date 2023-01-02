######################################################
//             Default Tags Variables               //
######################################################

locals {
  default_tags = merge({
    Environment = "${var.env}"
    System      = "Terraform"
  }, var.input_tags)
}