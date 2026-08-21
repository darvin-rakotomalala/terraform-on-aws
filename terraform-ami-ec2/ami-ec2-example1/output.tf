output "ami_id" {
  value = aws_ami_from_instance.ec2ami.id
}

# Output the public IP of the instance to easily access it
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2instance.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2instance.id
}
