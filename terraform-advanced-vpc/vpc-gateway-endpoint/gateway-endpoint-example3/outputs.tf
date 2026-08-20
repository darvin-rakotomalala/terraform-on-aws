output "vpc_a_bastion_host_IP" {
  value = module.vpc_a_bastion_host.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}
