######################################################
//                   Create VPC                     //
######################################################

resource "aws_vpc" "vpc" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.default_tags, {
    Name = format("vpc-%s-%s", 
                  var.project_name, 
                  var.env)
  })
}

data "aws_vpc" "selected" {
  depends_on           = [aws_vpc.vpc]
  id                   = var.create_vpc ? aws_vpc.vpc[0].id : var.vpc_id
}


######################################################
//              Create Internet G/W                 //
######################################################

resource "aws_internet_gateway" "igw" {
  count                = var.create_vpc ? 1 : 0
  vpc_id               = data.aws_vpc.selected.id

  tags = merge(
    local.default_tags, {
    Name = format("igw-%s-%s", 
                  var.project_name, 
                  var.env)
  })
}


######################################################
//             Create Public Subnet                 //
######################################################

resource "aws_subnet" "public_subnets" {
  count                   = var.create_pub_subnet ? length(var.pub_sub_cidr) : 0

  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = var.pub_sub_cidr[count.index].cidr
  availability_zone       = var.pub_sub_cidr[count.index].az

  map_public_ip_on_launch = true

  tags = merge(
    local.default_tags, {
    // ex. sub-test-prd-pub-a
    Name = format("sub-%s-%s-pub-%s", 
                  var.project_name, 
                  var.env, 
                  substr(split("-", var.pub_sub_cidr[count.index].az)[2], 1, 1))
  })
}


######################################################
//            Create Private Subnet                 //
######################################################

resource "aws_subnet" "private_subnets" {
  count                   = var.create_pri_subnet ? length(var.pri_sub_cidr) : 0

  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = var.pri_sub_cidr[count.index].cidr
  availability_zone       = var.pri_sub_cidr[count.index].az


  tags = merge(
    local.default_tags, {
    // ex. sub-test-prd-pri-a
    Name = format("sub-%s-%s-pri-%s",
                  var.project_name, 
                  var.env, 
                  substr(split("-", var.pri_sub_cidr[count.index].az)[2], 1, 1))
  })
}


######################################################
//               Create DB Subnet                   //
######################################################

resource "aws_subnet" "db_subnets" {
  count                   = var.create_db_subnet ? length(var.db_sub_cidr) : 0

  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = var.db_sub_cidr[count.index].cidr
  availability_zone       = var.db_sub_cidr[count.index].az

  tags = merge(
    local.default_tags, {
    // ex. sub-test-prd-db-a
    Name = format("sub-%s-%s-db-%s", 
                  var.project_name, 
                  var.env, 
                  substr(split("-", var.db_sub_cidr[count.index].az)[2], 1, 1))
  })
}


######################################################
//              Create Elastic IP                   //
######################################################

resource "aws_eip" "eip_nat" {
  depends_on = [aws_internet_gateway.igw]
  count      = var.create_nat ? 1 : 0

  vpc        = true

  tags = merge(
    local.default_tags, {
    Name = format("eip-%s-%s-nat", 
                  var.project_name, 
                  var.env)
  })
}


######################################################
//                Create NAT G/W                    //
######################################################

resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.igw]
  count         = var.create_nat ? 1 : 0

  allocation_id = aws_eip.eip_nat[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = merge(
    local.default_tags, {
    Name = format("nat-%s-%s", 
                  var.project_name, 
                  var.env)
  })
}


#####################################################
//           Create Public Route Table             //
#####################################################

resource "aws_route_table" "public_rtb" {
  count        = var.create_vpc ? 1 : 0
  vpc_id       = data.aws_vpc.selected.id

  // "0.0.0.0/0" 에 대해 IGW 로 라우팅
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }

  tags = merge(
    local.default_tags, {
    Name = format("rtb-%s-%s-pub", 
                  var.project_name, 
                  var.env)
  })
}

  // association public subnet with route table

resource "aws_route_table_association" "public_subnets_association" {
  count          = (length(aws_route_table.public_rtb) > 0) ? length(var.pub_sub_cidr) : 0

  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb[0].id
}


#####################################################
//          Create Private Route Table             //
#####################################################

resource "aws_route_table" "private_rtb" {
  count        = var.create_vpc ? 1 : 0
  vpc_id       = data.aws_vpc.selected.id

  dynamic "route" {
    for_each = var.pri_sub_cidr[count.index].use_nat ? [true] : []

    content {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
    }
  }
  tags = merge(
    local.default_tags, {
    Name = format("rtb-%s-%s-pri", 
                  var.project_name, 
                  var.env)
  })
}

  // association private subnet with route table

resource "aws_route_table_association" "private_subnets_association" {
  count          = (length(aws_route_table.private_rtb) > 0) ? length(var.pri_sub_cidr) : 0

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rtb[0].id
}


#####################################################
//             Create DB Route Table               //
#####################################################

resource "aws_route_table" "db_rtb" {
  count        = var.create_vpc ? 1 : 0
  vpc_id       = data.aws_vpc.selected.id

  dynamic "route" {
    for_each = var.db_sub_cidr[count.index].use_nat ? [true] : []

    content {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
    }
  }
  tags = merge(
    local.default_tags, {
    Name = format("rtb-%s-%s-db", 
                  var.project_name, 
                  var.env)
  })
}

  // association db subnet with route table

resource "aws_route_table_association" "db_subnets_association" {
  count          = (length(aws_route_table.db_rtb) > 0) ? length(var.db_sub_cidr) : 0

  subnet_id      = aws_subnet.db_subnets[count.index].id
  route_table_id = aws_route_table.db_rtb[0].id        
}