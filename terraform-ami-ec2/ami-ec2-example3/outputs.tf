output "KKE_ami_id" {
  value = aws_ami_from_instance.devops_ami.id
}

output "KKE_new_instance_id" {
  value = aws_instance.devops_ec2_new.id
}
