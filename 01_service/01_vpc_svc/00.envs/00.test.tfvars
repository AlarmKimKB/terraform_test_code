## Common Var ##
aws_region   = "ap-northeast-2"
project_name = "terraform"
env          = "test"

## VPC ##
vpc_cidr     = "192.168.0.0/16"

pub_sub_cidr = [
    {az = "ap-northeast-2a" , cidr = "192.168.10.0/24"},
    {az = "ap-northeast-2c" , cidr = "192.168.20.0/24"}
]

pri_sub_cidr = [
    {az = "ap-northeast-2a" , cidr = "192.168.30.0/24" , use_nat = true},
    {az = "ap-northeast-2c" , cidr = "192.168.40.0/24" , use_nat = true}
]

db_sub_cidr  = [
    {az = "ap-northeast-2a" , cidr = "192.168.50.0/24" , use_nat = true},
    {az = "ap-northeast-2c" , cidr = "192.168.60.0/24" , use_nat = true}
]


