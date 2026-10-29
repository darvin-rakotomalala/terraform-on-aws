###########################################################
# 1 — Setting Up AWS Secrets Manager
###########################################################
# Create a Secrets Manager secret
# Create a secrets manager secret in the primary region (us-east-1)
resource "aws_secretsmanager_secret" "application_secret" {
  name                    = "awsmorocco/application/secrets"
  description             = "Secrets for the AWS Morocco application, a multi-region secret managed by Terraform."
  recovery_window_in_days = 7

  # Optional: Use our KMS key from Part 1 
  # ARN or Id of the AWS KMS key to be used to encrypt the secret 
  # values in the versions stored in this secret.
  # kms_key_id = aws_kms_key.secrets_key.arn

  # Define the replica region(s)
  replica {
    region = "us-west-2"
    # Optional: specify a custom KMS key ARN for the replica region
    # kms_key_id = aws_kms_key.secrets_key.arn
  }
}

resource "random_password" "password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Create a secret version with initial secret values
resource "aws_secretsmanager_secret_version" "application_secret_version" {
  secret_id = aws_secretsmanager_secret.application_secret.id

  secret_string = jsonencode({
    db_username = "root69127"
    db_password = random_password.password.result
    # api_key     = data.aws_kms_secrets.application_secrets.plaintext["api_key"]
  })
}

# Create an IAM policy for accessing the secret
resource "aws_iam_policy" "secret_access_policy" {
  name        = "awsmorocco-secret-access-policy"
  description = "Policy for accessing application secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.application_secret.arn
      }
    ]
  })
}

###########################################################
# 2 — Secrets Rotation
###########################################################
# Lambda execution role for the rotation function
resource "aws_iam_role" "rotation_lambda_role" {
  name = "awsmorocco-secret-rotation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

/*
data "aws_region" "current" {}

# Enable rotation for the secret
resource "aws_secretsmanager_secret_rotation" "secret_rotation" {
  secret_id           = aws_secretsmanager_secret.application_secret.id
  rotation_lambda_arn = "arn:aws:lambda:${data.aws_region.current.region}:${data.aws_caller_identity.current.account_id}:function:awsmorocco-rotation-function"
  # rotation_lambda_arn = aws_lambda_function.example.arn

  rotation_rules {
    automatically_after_days = 30
  }
}
*/

###########################################################
# 3 — Accessing Secrets
###########################################################
# Fetch the entire secret
data "aws_secretsmanager_secret_version" "application_secrets" {
  secret_id     = aws_secretsmanager_secret.application_secret.id
  version_stage = "AWSCURRENT"
}

locals {
  secrets = jsondecode(data.aws_secretsmanager_secret_version.application_secrets.secret_string)
}

# Use in resources
resource "aws_db_instance" "application_db" {
  allocated_storage    = 10
  identifier           = "mydb69127"
  db_name              = "mydb69127"
  engine               = "mysql"
  engine_version       = "8.4"
  instance_class       = "db.t3.micro"
  username             = local.secrets.db_username
  password             = local.secrets.db_password
  parameter_group_name = "default.mysql8.4"

  publicly_accessible    = false
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.project.name
  vpc_security_group_ids = [aws_security_group.private_database_sg.id]
}
