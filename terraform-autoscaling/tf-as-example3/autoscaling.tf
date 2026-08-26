
# Launch template for EC2 Instances with Apache install configuration
resource "aws_launch_template" "template" {
  name_prefix                          = "tf-LT-"
  image_id                             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type                        = "t2.micro"
  key_name                             = "my-key-pair"
  instance_initiated_shutdown_behavior = "terminate"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.tf_sg.id]
  }

  user_data = base64encode(file("apache-install.sh"))

  lifecycle {
    create_before_destroy = true
  }
}

# Define ASG
resource "aws_autoscaling_group" "tf_asg" {
  vpc_zone_identifier = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  desired_capacity          = 2
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "EC2"

  tag {
    key                 = "Name"
    value               = "tf-ASG"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
