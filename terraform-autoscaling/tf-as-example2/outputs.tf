output "asg_sg" {
  value       = aws_security_group.asg_sg.id
  description = "This is Security Group for autoscaling launch configuration."
}

output "aws_launch_template" {
  value       = aws_launch_template.template.id
  description = "This is ASG Launch Configuration ID."
}

output "autoscaling_group" {
  value       = aws_autoscaling_group.my_asg.id
  description = "This is ASG ID."
}
