# =============================================================================
# PRIMARY REGION - EC2, ALB
# =============================================================================

# EC2 Instance - Primary
resource "aws_instance" "primary" {
  provider               = aws.primary
  ami                    = data.aws_ami.amazon_linux_primary.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.primary_public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_primary.id]

  user_data_base64 = base64encode(templatefile("${path.module}/user_data.sh", {
    region      = "us-east-1"
    region_name = "N. Virginia"
    role        = "PRIMARY"
    role_color  = "#1a5f2a"
    badge_color = "#FFD700"
    text_color  = "#90EE90"
  }))

  tags = {
    Name = "${var.project_name}-primary-web"
  }
}

# Application Load Balancer - Primary
resource "aws_lb" "primary" {
  provider           = aws.primary
  name               = "${var.project_name}-primary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_primary.id]
  subnets            = [aws_subnet.primary_public_1.id, aws_subnet.primary_public_2.id]

  tags = {
    Name = "${var.project_name}-primary-alb"
  }
}

# Target Group - Primary
resource "aws_lb_target_group" "primary" {
  provider = aws.primary
  name     = "${var.project_name}-primary-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.primary.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-primary-tg"
  }
}

# Target Group Attachment - Primary
resource "aws_lb_target_group_attachment" "primary" {
  provider         = aws.primary
  target_group_arn = aws_lb_target_group.primary.arn
  target_id        = aws_instance.primary.id
  port             = 80
}

# ALB Listener - HTTPS (Primary)
resource "aws_lb_listener" "primary_https" {
  provider          = aws.primary
  load_balancer_arn = aws_lb.primary.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.primary.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.primary.arn
  }
}

# ALB Listener - HTTP Redirect (Primary)
resource "aws_lb_listener" "primary_http" {
  provider          = aws.primary
  load_balancer_arn = aws_lb.primary.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# =============================================================================
# SECONDARY REGION - EC2, ALB
# =============================================================================

# EC2 Instance - Secondary
resource "aws_instance" "secondary" {
  provider               = aws.secondary
  ami                    = data.aws_ami.amazon_linux_secondary.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.secondary_public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_secondary.id]

  user_data_base64 = base64encode(templatefile("${path.module}/user_data.sh", {
    region      = "us-west-2"
    region_name = "Oregon"
    role        = "SECONDARY"
    role_color  = "#8B0000"
    badge_color = "#FFA500"
    text_color  = "#FFB6C1"
  }))

  tags = {
    Name = "${var.project_name}-secondary-web"
  }
}

# Application Load Balancer - Secondary
resource "aws_lb" "secondary" {
  provider           = aws.secondary
  name               = "${var.project_name}-secondary-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_secondary.id]
  subnets            = [aws_subnet.secondary_public_1.id, aws_subnet.secondary_public_2.id]

  tags = {
    Name = "${var.project_name}-secondary-alb"
  }
}

# Target Group - Secondary
resource "aws_lb_target_group" "secondary" {
  provider = aws.secondary
  name     = "${var.project_name}-secondary-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.secondary.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-secondary-tg"
  }
}

# Target Group Attachment - Secondary
resource "aws_lb_target_group_attachment" "secondary" {
  provider         = aws.secondary
  target_group_arn = aws_lb_target_group.secondary.arn
  target_id        = aws_instance.secondary.id
  port             = 80
}

# ALB Listener - HTTPS (Secondary)
resource "aws_lb_listener" "secondary_https" {
  provider          = aws.secondary
  load_balancer_arn = aws_lb.secondary.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate_validation.secondary.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.secondary.arn
  }
}

# ALB Listener - HTTP Redirect (Secondary)
resource "aws_lb_listener" "secondary_http" {
  provider          = aws.secondary
  load_balancer_arn = aws_lb.secondary.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
