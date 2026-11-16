# -------- Load Balancer ---------
# When creating load balancer you need more that just the load balancer resource
# You have to include the Load Balancer resource, the load balancer listener, target group, and target group attachements 
resource "aws_lb" "project_lb" {
  name               = "project-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_ALB.id]
  subnets            = [aws_subnet.public_project_subnet_1a.id, aws_subnet.public_project_subnet_1b.id]

  enable_deletion_protection = false # if true it can cause problems or it wont destroy

  tags = {
    Environment = "project-alb"
  }
}

resource "aws_lb_target_group" "project_lb_tg" {
  name     = "project-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project.id
}

resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.project_lb_tg.arn
  }
}

# These attachments attach our instances to our target group
resource "aws_lb_target_group_attachment" "project" {
  target_group_arn = aws_lb_target_group.project_lb_tg.arn
  target_id        = aws_instance.project_front_end_1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "project2" {
  target_group_arn = aws_lb_target_group.project_lb_tg.arn
  target_id        = aws_instance.project_front_end_1b.id
  port             = 80
}
