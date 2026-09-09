data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "webserver_lt" {
  name_prefix   = "webserver"
  image_id      = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  # subnet_id     = aws_subnet.webserver_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  # vpc_security_group_ids = ["${aws_security_group.allow_http.id}","${aws_security_group.allow_ssh.id}"]

  user_data = base64encode(templatefile("user_data.tftpl", {}))
}

resource "aws_lb" "webserver_alb" {
  name                       = "webserver-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.allow_http_alb.id]
  subnets                    = [for subnet in aws_subnet.public_subnets : subnet.id]
  enable_deletion_protection = false # PoC option!!
  tags = {
    Environment = "demo"
  }
}

# Define a listener
resource "aws_alb_listener" "webserver_alb_listener" {
  load_balancer_arn = aws_lb.webserver_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.webtg.arn
    type             = "forward"
  }
}

# Connect ASG up to the Application Load Balancer
resource "aws_alb_target_group" "webtg" {
  name     = "webtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_demo.id
}

resource "aws_autoscaling_group" "webserver_autoscaler" {
  desired_capacity    = 0
  max_size            = 2
  min_size            = 0
  vpc_zone_identifier = aws_subnet.public_subnets[*].id
  launch_template {
    id      = aws_launch_template.webserver_lt.id
    version = aws_launch_template.webserver_lt.latest_version
  }
  target_group_arns = [
    aws_alb_target_group.webtg.arn
  ]
}
