resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda-EC2-IAM-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy_attachment" "ec2_policy" {
  name       = "lambda-ec2-policy"
  roles      = [aws_iam_role.lambda_iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
