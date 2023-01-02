## Common Var ##
s3_backend_vpc = {
    bucket = "{S3-bucket-name}"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
}

## Bastion ##
create_bastion   = true
bastion_type     = "t3.micro"
keypair_name     = "{Key-name}"

sg_bastion_inbound_rule = {
    type        = "ingress"
    description = "SSH via Office"
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

## Web ## 
web_type     = "t3.small"

web_ebs      = {
    volume_type = "gp3"
    volume_size = 30
    encrypted   = false
    kms_key_id  = null
}

web_autoscaling_config = {
    min_size          = 1
    max_size          = 2
    desired_capacity  = 1
    health_check_type = "EC2"
}