resource "aws_security_group" "sg_alb" {
  description = "ALB for Web Security Group"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  name   = format("scg-%s-%s-alb",
           var.project_name, 
           var.env)

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "http allow"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "https allow"
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow to all"
  }

  tags   = merge(
    local.default_tags, {
    Name = format("scg-%s-%s-alb",
           var.project_name, 
           var.env)
  })
}


resource "aws_lb" "alb_web" {
  count = var.create_web ? 1 : 0

  name = format("alb-%s-%s-web",
         var.project_name,
         var.env)

  load_balancer_type = "application"
  subnets            = [ for subnet_id in data.terraform_remote_state.vpc.outputs.public_subnet_ids : subnet_id ]
  security_groups    = [ aws_security_group.sg_alb.id ]

  tags   = merge(
    local.default_tags, {
    Name = format("alb-%s-%s-web",
           var.project_name, 
           var.env)
  })
}

resource "aws_lb_target_group" "tg_web" {
  count  = var.create_web ? 1 : 0

  name   = format("tg-%s-%s-web",
           var.project_name, 
           var.env)

  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(
    local.default_tags, {
    Name = format("tg-%s-%s-web",
           var.project_name, 
           var.env)
  })
}

resource "aws_lb_listener" "alb_http" {
  count = var.create_web ? 1 : 0

  load_balancer_arn = aws_lb.alb_web[0].arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_web[0].arn
  } 
}

# resource "aws_lb_listener_rule" "alb_rule" {
#   count        = var.create_web ? 1 : 0

#   listener_arn = aws_lb_listener.alb_http[0].arn
#   priority     = 100

#   condition {
#     path_pattern {
#       values = ["*"]
#     }
#   }

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg_web[0].arn
#   }
# }

