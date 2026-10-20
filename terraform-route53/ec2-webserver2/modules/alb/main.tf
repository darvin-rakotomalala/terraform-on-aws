####################################################
# create application load balancer
####################################################
resource "aws_lb" "aws-application_load_balancer" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_alb[0]]
  //subnets                    = [var.public_subnets[0],var.public_subnets[1] ,var.public_subnets[2],var.public_subnets[3]]
  subnets                    = tolist(var.public_subnets)
  enable_deletion_protection = false

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-alb"
  })
}

####################################################
# create target group for ALB
####################################################
resource "aws_lb_target_group" "alb_target_group" {
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-alb-tg"
  })
}

####################################################
# create a listener on port 80 with redirect action
####################################################
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.aws-application_load_balancer.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.id

  }
}

####################################################
# Target Group Attachment with Instance
####################################################
resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = element(var.instance_ids, count.index)
}
