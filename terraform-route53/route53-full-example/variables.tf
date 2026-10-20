# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "public_zone" {
  type = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "ip_address" {
  description = "IP address for A record"
  type        = string
}

variable "cname_target" {
  description = "Alias Records for AWS CloudFront"
  type        = string
}

variable "primary_ip" {
  description = "PRIMARY IP address for A record"
  type        = string
}

variable "secondary_ip" {
  description = "SECONDARY IP address for A record"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Target for CNAME record for CloudFront"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "Target for CNAME record for CloudFront"
  type        = string
}

variable "alb_dns_name" {
  description = "Alias record for the ALB DNS name"
  type        = string
}

variable "primary_alb_dns" {
  description = "Alias record for the PRIMARY ALB DNS name"
  type        = string
}

variable "primary_alb_zone_id" {
  description = "Alias record for the PRIMARY ALB zone id"
  type        = string
}

variable "us_west_2_ip" {
  description = "www_latency_us for A record"
  type        = string
}

variable "eu_west_1_ip" {
  description = "www_latency_eu for A record"
  type        = string
}

variable "us_ip" {
  description = "US IP address for A record"
  type        = string
}

variable "default_ip" {
  description = "Default IP address for A record"
  type        = string
}

