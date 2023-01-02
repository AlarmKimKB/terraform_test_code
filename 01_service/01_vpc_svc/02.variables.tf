######################################################
//                Common Variables                  //
######################################################

variable "project_name" {
  description = "프로젝트 이름"
}

variable "env" {
  description = "VPC 환경 (ex. dev , stg , prd , qa)"
}

variable "input_tags" {
  description = "모든 리소스에 넣을 Tag 입력, (기본 : 'Environment' , 'System')"
  type = map(string)
  default = {
    // ex. Backup = yes

  }
}

variable "aws_region" {
  description = "배포할 Region"
  type        = string
}


######################################################
//                 VPC Variables                    //
######################################################

variable "vpc_cidr" {
  description = "VPC CIDR Block. (ex. 10.0.0.0/16)"
  type        = string
}

variable "create_vpc" {
  description = "VPC 생성 유무, (생성 : 'true' , 미생성 : 'false')"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "기존 생성되어 사용할 VPC ID"
  type        = string
  default     = null
}

######################################################
//                Subnet Variables                  //
######################################################

variable "create_pub_subnet" {
  description = "Public Subnet 생성 유무, ( 생성 : 'true' , 미생성 : 'false' )"
  type        = bool
  default     = true
}

variable "pub_sub_cidr" {
  description = "Public CIDR Block.  ex. [{az = 'ap-northeast-2a' , cidr = '10.0.10.0/24'}]"
  type        = list(object({
                  // Subnet 가용 영역
                  az    =   string
                  // Subnet CIDR
                  cidr  =   string
                }))
  default     = []
}

variable "create_pri_subnet" {
  description = "Private Subnet 생성 유무, ( 생성 : 'true' , 미생성 : 'false' )"
  type        = bool
  default     = true
}

variable "pri_sub_cidr" {
  description = "Private CIDR Block.  ex. [{az = 'ap-northeast-2a' , cidr = '10.0.10.0/24' , use_nat = true}]"
  type        = list(object({
                  // Subnet 가용 영역
                  az      =   string
                  // Subnet CIDR
                  cidr    =   string
                  // Nat G/W 필요 유무 ('true' : 필요)
                  use_nat =   bool
                }))
  default     = []
}

variable "create_db_subnet" {
  description = "DB Subnet 생성 유무, ( 생성 : 'true' , 미생성 : 'false' )"
  type        = bool
  default     = true
}

variable "db_sub_cidr" {
  description = "DB CIDR Block.  ex. [{az = 'ap-northeast-2a' , cidr = '10.0.30.0/24' , use_nat = true}]"
  type        = list(object({
                  // Subnet 가용 영역
                  az      =   string
                  // Subnet CIDR
                  cidr    =   string
                  // Nat G/W 필요 유무 ('true' : 필요)
                  use_nat =   bool
                }))
  default     = []
}

######################################################
//                  NAT Variables                   //
######################################################

variable "create_nat" {
  description = "NAT Gateway 생성 유무"
  type        = bool
  default     = true
}
