# Auto Scaling Group Creation
resource "aws_launch_template" "template" {
  name_prefix                          = "tf-LT-"
  image_id                             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type                        = "t2.micro"
  key_name                             = "my-key-pair"
  instance_initiated_shutdown_behavior = "terminate"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.autoscaling.id]
  }

  user_data = base64encode(file("apache-install.sh"))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name_prefix               = "tf-asg"
  vpc_zone_identifier       = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 60
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "tf-asg"
    propagate_at_launch = true
  }
}
