/*
    The Application Load Balancer distributes incoming traffic across our ECS tasks 
    running in private subnets.

    Our ALB listens on port 80 and forwards requests to the ECS service through a target group.
*/
# Creating appication load bakancer
resource "aws_alb" "main" {
  name            = "${var.app_name}-alb"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]
}

# Creating a target group
resource "aws_alb_target_group" "app" {
  name        = "${var.app_name}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip" # IP target type for Fargate tasks

  health_check {
    healthy_threshold   = "3"
    port                = var.app_port
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "3"
  }
}

# Creating a listener for the ALB
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.id
  }
}
/*
    Notes:
    - ALB: Created in public subnets so it’s internet-facing.
    - Target Group: ECS tasks are registered here via their private IPs.
    - Health Check: Ensures only healthy containers receive traffic.
    - Listener: Listens on port 80 and forwards traffic to the target group.

    With this ALB in place, our application can securely receive and route traffic 
    from the internet into private ECS tasks.
*/