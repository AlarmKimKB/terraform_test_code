resource "aws_security_group" "sg_web" {
  description = "Web Server Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  name   = format("scg-%s-%s-web",
           var.project_name, 
           var.env)

  tags   = merge(
    local.default_tags, {
    Name = format("scg-%s-%s-web",
           var.project_name, 
           var.env)
  })
}

resource "aws_security_group_rule" "sg_web_inbound" {
  security_group_id = aws_security_group.sg_web.id

  description              = "SSH via Bastion"
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_bastion.id
}

resource "aws_security_group_rule" "sg_web_inbound2" {
  security_group_id = aws_security_group.sg_web.id

  description              = "http via Bastion"
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_alb.id
}

resource "aws_security_group_rule" "sg_web_outbound" {
  security_group_id = aws_security_group.sg_web.id

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "allow to all"
}

resource "aws_launch_template" "web_launch_template" {
  count         = var.create_web ? 1 : 0

  description   = "Web Server Launch Template"
  name          = format("lat-%s-%s-web",
                  var.project_name, 
                  var.env)

  image_id      = data.aws_ami.amazon_linux2.id
  instance_type = var.web_type
  key_name      = var.keypair_name
  vpc_security_group_ids = [aws_security_group.sg_web.id]

  user_data = base64encode(file("${path.root}/12.web-user-data.sh"))

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.web_ebs.volume_size
      volume_type = var.web_ebs.volume_type
      encrypted   = var.web_ebs.encrypted
      kms_key_id  = var.web_ebs.encrypted ? var.web_ebs.kms_key_id : null

      delete_on_termination = true
    }
  }
}

# resource "aws_launch_configuration" "web_launch_config" {
#   count                       = var.create_web ? 1 : 0

#   name                        = format("lac-%s-%s-web",
#                                 var.project_name, 
#                                 var.env)

#   image_id                    = data.aws_ami.amazon_linux2.id
#   instance_type               = var.web_type
#   key_name                    = var.keypair_name
#   security_groups             = [aws_security_group.sg_web.id]
#   associate_public_ip_address = false

#   user_data = templatefile("${path.root}/11.user-data.sh", {
#     hostname = format("%s-${count.index + 1}",
#                var.web_hostname)
#   })

#   # Required when using a launch configuration with an auto scaling group.
#   lifecycle {
#     create_before_destroy = true
#   }

#   root_block_device {
#     volume_type = var.web_ebs.volume_type
#     volume_size = var.web_ebs.volume_size
#     encrypted   = var.web_ebs.encrypted
#   }
# }

resource "aws_autoscaling_group" "asg_web" {
  count                = var.create_web ? 1 : 0

  name                 = format("asg-%s-%s-web",
                         var.project_name, 
                         var.env)

  # launch_configuration = aws_launch_configuration.web_launch_config[0].name
  vpc_zone_identifier  = [ for subnet_id in data.terraform_remote_state.vpc.outputs.private_subnet_ids : subnet_id ]

  min_size          = var.web_autoscaling_config.min_size
  max_size          = var.web_autoscaling_config.max_size
  desired_capacity  = var.web_autoscaling_config.desired_capacity
  health_check_type = var.web_autoscaling_config.health_check_type

  launch_template {
    id      = aws_launch_template.web_launch_template[0].id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg_web[0].arn]

  tag {
    propagate_at_launch = false
    key                 = "Name"
    value               = format("asg-%s-%s-web",
                          var.project_name, 
                          var.env)
  }

  tag {
    propagate_at_launch = true
    key                 = "Name"
    value               = format("ec2-%s-%s-web",
                          var.project_name, 
                          var.env)
  }
}
