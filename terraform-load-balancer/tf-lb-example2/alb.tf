// ALB
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web-sg.id]
  subnets            = [aws_subnet.public-subnet-a.id, aws_subnet.public-subnet-b.id, aws_subnet.public-subnet-c.id]

  tags = {
    Environment = "tf-dev"
  }
}

// Listener
resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_a.arn
  }
}

resource "aws_lb_listener_rule" "rule_b" {
  listener_arn = aws_lb_listener.my_alb_listener.arn
  priority     = 60

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_b.arn
  }

  condition {
    path_pattern {
      values = ["/images/*"]
    }
  }
}

resource "aws_lb_listener_rule" "rule_c" {
  listener_arn = aws_lb_listener.my_alb_listener.arn
  priority     = 40

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_c.arn
  }

  condition {
    path_pattern {
      values = ["/register/*"]
    }
  }
}


