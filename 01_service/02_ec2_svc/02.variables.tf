######################################################
//                Common Variables                  //
######################################################

variable "input_tags" {
  description = "모든 리소스에 넣을 Tag 입력, (기본 : 'Environment' , 'System')"
  type = map(string)
  default = {}
}

variable "s3_backend_vpc" {
  type = object({
    bucket = string
    key    = string
    region = string
  })
}

######################################################
//                Bastion Variables                 //
######################################################

variable "create_bastion" {
  description = "Bastion 생성 유무"
  type        = bool
}

variable "bastion_type" {
  description = "Bastion EC2 Type"
  type        = string
}

variable "keypair_name" {
  description = "Keypair Name"
  type        = string
}

######################################################
//               Bastion SG Variables               //
######################################################

variable "sg_bastion_inbound_rule" {
  description = "Bastion Security Group Rule"
  type        = object({
    type        = string
    description = string
    port        = number
    protocol    = string
    cidr_blocks = list(string)
    })
}

######################################################
//                   Web Variables                  //
######################################################

variable "create_web" {
  description = "Web 서버 생성 유무"
  type        = bool
  default     = true
}

variable "web_type" {
  description = "Web EC2 Type"
  type        = string
}

variable "web_ebs" {
  description = "Web EC2 EBS Configuration"
  type        = object({
    volume_type = string        # standard , gp2 , gp3 , io1 , io2 , sc1
    volume_size = number
    encrypted   = bool
    kms_key_id  = any
  })
}

variable "web_autoscaling_config" {
  description = "Web EC2 AutoScaling Configuration"
  type        = object({
    min_size          = number
    max_size          = number
    desired_capacity  = number
    health_check_type = string
  })
}   