data "aws_ami" "amazon_linux2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

resource "aws_security_group" "sg_bastion" {
  description = "Bastion Host Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  name   = format("scg-%s-%s-bastion",
           var.project_name, 
           var.env)

  tags   = merge(
    local.default_tags, {
    Name = format("scg-%s-%s-bastion",
           var.project_name, 
           var.env)
  })
}

resource "aws_security_group_rule" "sg_bastion_inbound" {
  security_group_id = aws_security_group.sg_bastion.id

  type        = var.sg_bastion_inbound_rule.type
  from_port   = var.sg_bastion_inbound_rule.port
  to_port     = var.sg_bastion_inbound_rule.port
  protocol    = var.sg_bastion_inbound_rule.protocol
  cidr_blocks = var.sg_bastion_inbound_rule.cidr_blocks
  description = var.sg_bastion_inbound_rule.description
}

resource "aws_security_group_rule" "sg_bastion_outbound" {
  security_group_id = aws_security_group.sg_bastion.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "allow to all"
}

resource "aws_instance" "bastion" {
  count           = var.create_bastion ? 1 : 0

  ami             = data.aws_ami.amazon_linux2.id
  instance_type   = var.bastion_type
  key_name        = var.keypair_name

  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]

  user_data = file("${path.root}/11.bastion-user-data.sh")

  tags = merge(
    local.default_tags, {
    Name = format("ec2-%s-%s-bastion", 
                  var.project_name, 
                  var.env)
  })
}