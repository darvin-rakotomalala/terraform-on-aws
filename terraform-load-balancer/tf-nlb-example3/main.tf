# creating nlb
resource "aws_lb" "nlb" {
  name                             = var.nlb_name
  internal                         = true
  load_balancer_type               = "network"
  enable_deletion_protection       = true
  enable_cross_zone_load_balancing = true
  subnets                          = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
  security_groups                  = [aws_security_group.web-sg.id]
}

# create target group
resource "aws_lb_target_group" "nlb-example-tg" {
  name     = "${aws_lb.nlb.name}-tg"
  port     = 443
  protocol = "TCP"
  vpc_id   = aws_vpc.example_vpc.id

  health_check {
    protocol            = "TCP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# attach listener to NLB which will route traffic to target group .
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "443"
  protocol          = "TCP"
  depends_on        = [aws_lb_target_group.nlb-example-tg]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-example-tg.arn
  }
}

// Target group attachment A
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
  target_group_arn = aws_lb_target_group.nlb-example-tg.arn
  target_id        = aws_instance.instance_a.id
  port             = 80
}

// Target group attachment B
resource "aws_lb_target_group_attachment" "tg_attachment_b" {
  target_group_arn = aws_lb_target_group.nlb-example-tg.arn
  target_id        = aws_instance.instance_b.id
  port             = 80
}
