variable "region" {
  description = "AWS Deployment region.."
  default     = "us-east-1"
}

variable "aws_lb_arn" {
  description = "ARN of your LoadBalance that you want to attach with WAF.."
  default     = "arn:aws:elasticloadbalancing:us-east-1:583524027596:loadbalancer/app/front/92948312ab98a653"
}
