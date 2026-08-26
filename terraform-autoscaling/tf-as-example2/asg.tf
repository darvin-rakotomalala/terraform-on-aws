# Create a new EC2 launch template. This will be used with our auto scaling group.
data "template_file" "test" {
  template = <<EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    sudo systemctl enable httpd
    echo "<h1>Hello from EC2 ASG!</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Address:</strong> $(hostname -I | cut -d" " -f1)</p>" > /var/www/html/index.html
    sudo systemctl restart apache2
  EOF
}

resource "aws_launch_template" "template" {
  name_prefix                          = "tf-LT-"
  image_id                             = "ami-020cba7c55df1f615" # Ubuntu Server 24.04 LTS, SSD Volume Type (us-east-1)
  instance_type                        = "t2.micro"
  key_name                             = "my-key-pair"
  instance_initiated_shutdown_behavior = "terminate"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.asg_sg.id]
  }

  user_data = base64encode(data.template_file.test.rendered)

  lifecycle {
    create_before_destroy = true
  }

}

# Define Autoscaling Group
resource "aws_autoscaling_group" "my_asg" {
  name = "tf-asg-example"

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }

  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = ["subnet-0c8df5b912dcf0400", "subnet-0e32beb8d1675f0d2"]
  health_check_type         = "EC2"
  termination_policies      = ["OldestInstance"]
  health_check_grace_period = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "tf-ASG"
    propagate_at_launch = true
  }
}

# Add an automated scaling event
/*
  For example, the policy below uses a Cloudwatch metric alarm resource 
  to scale down the number of EC2 instances by one when it is detected that 
  less than 25% CPU is used over the course of 5 x 30 second evaluation periods (2m 30sec) on average.
*/
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "tf-scale-down"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 120
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_description   = "Monitors CPU utilization"
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  alarm_name          = "tf-scale-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "25"
  evaluation_periods  = "5"
  period              = "30"
  statistic           = "Average"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }
}

# The example below shows an autoscaling schedule resource block
resource "aws_autoscaling_schedule" "schedule" {
  scheduled_action_name  = "tf-schedule"
  min_size               = 3
  max_size               = 6
  desired_capacity       = 3
  start_time             = "2025-09-10T06:00:00Z"
  end_time               = "2025-09-11T20:00:00Z"
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}
