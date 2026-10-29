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
        Resource = [aws_secretsmanager_secret.credentials.arn]
      }
    ]
  })
}
