output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.aurora_mysql_cluster.endpoint
  description = "The endpoint for the Aurora MySQL cluster."
}
