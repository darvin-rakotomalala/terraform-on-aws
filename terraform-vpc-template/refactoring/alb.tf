resource "aws_lb" "project_lb" {
  name                       = "project-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.public_ALB.id]
  subnets                    = aws_subnet.public_project_subnet[*].id
  enable_deletion_protection = false # if true it can cuase problems or it wont destroy

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

#We now only have one TG attachment that uses all the instances made from this target id resource. 
resource "aws_lb_target_group_attachment" "project" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.project_lb_tg.arn
  target_id        = aws_instance.project_front_end[count.index].id
  port             = 80
}
