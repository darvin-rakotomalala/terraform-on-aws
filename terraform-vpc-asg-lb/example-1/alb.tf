# Create Load Balancer
resource "aws_alb" "CustomELB" {
  name            = "tf-CustomELB"
  security_groups = [aws_security_group.elb_sg.id]
  subnets         = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id]
  tags = {
    Name = "tf-CustomELB"
  }
}

# Create Target Group
resource "aws_lb_target_group" "CustomTG" {
  name        = "tf-CustomTG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.CustomVPC.id
  target_type = "instance"
}

# Create Load Balancer Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.CustomELB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.CustomTG.arn
      }
      stickiness {
        enabled  = true
        duration = 28800
      }
    }
  }
}
