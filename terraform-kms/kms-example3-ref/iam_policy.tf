data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_rotation_role" {
  name = "lambda_rotation_role"

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

resource "aws_iam_role_policy_attachment" "lambda_rotation_policy_attachment" {
  role       = aws_iam_role.lambda_rotation_role.name
  policy_arn = aws_iam_policy.lambda_rotation_policy.arn
}

resource "aws_iam_policy" "lambda_rotation_policy" {
  name = "lambda_rotation_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [aws_secretsmanager_secret.application_secret.arn]
      }
    ]
  })
}

# Example of a more detailed IAM policy with granular permissions
resource "aws_iam_policy" "detailed_secret_access_policy" {
  name        = "demo-granular-secret-access"
  description = "Granular access policy for application secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSecretsRead"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = [
          aws_secretsmanager_secret.application_secret.arn
        ]
        Condition = {
          StringEquals = {
            "aws:PrincipalTag/Environment" : ["development", "production"]
          }
        }
      },
      {
        Sid    = "AllowSecretsWrite"
        Effect = "Allow"
        Action = [
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecret"
        ]
        Resource = [
          aws_secretsmanager_secret.application_secret.arn
        ]
        Condition = {
          StringEquals = {
            "aws:PrincipalTag/Role" : "administrator"
          }
        }
      }
    ]
  })
}

# Resource-based policy for cross-account access
resource "aws_secretsmanager_secret_policy" "secret_resource_policy" {
  secret_arn = aws_secretsmanager_secret.application_secret.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableCrossAccountAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root" # Replace with actual account ID
        }
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "*"
      }
    ]
  })
}

###########################################################
# 4 — Examples — Integration with EC2 and ECS
###########################################################
# IAM role for EC2 Integration
resource "aws_iam_role" "ec2_role" {
  name = "demo-ec2-secrets-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach secrets access policy to EC2 role
resource "aws_iam_role_policy_attachment" "ec2_secret_policy" {
  policy_arn = aws_iam_policy.secret_access_policy.arn
  role       = aws_iam_role.ec2_role.name
}

/*
# IAM role for ECS Integration
# Task definition with secrets
resource "aws_ecs_task_definition" "application" {
  family                   = "demo-application"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name  = "application"
      image = "application:latest"
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = "${aws_secretsmanager_secret.application_secret.arn}:db_password::"
        },
        {
          name      = "API_KEY"
          valueFrom = "${aws_secretsmanager_secret.application_secret.arn}:api_key::"
        }
      ]
    }
  ])
}
*/
