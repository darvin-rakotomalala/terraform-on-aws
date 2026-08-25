# Output the cluster endpoint
output "aurora_cluster_endpoint" {
  value       = aws_rds_cluster.aurora_postgres.endpoint
  description = "The endpoint for the Aurora PostgreSQL cluster."
}
