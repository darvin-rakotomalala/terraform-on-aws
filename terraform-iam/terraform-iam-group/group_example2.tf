# users
resource "aws_iam_user" "company_A_analytics" {
  name = "company-A"
}

resource "aws_iam_user" "company_B_analytics" {
  name = "company-B"
}

# group
resource "aws_iam_group" "data_analytics_group" {
  name = "data-analytics"
}

# access_key
resource "aws_iam_access_key" "access_key_for_company_A" {
  user = aws_iam_user.company_A_analytics.name
}

resource "local_file" "company_access_key_file" {
  filename = "company_A_access_key.txt"
  content  = <<-EOT
    IAM User Credentials : ${aws_iam_user.company_A_analytics.name}
    Access Key: ${aws_iam_access_key.access_key_for_company_A.id}
    Secret Key: ${aws_iam_access_key.access_key_for_company_A.secret}
  EOT
}

# Attach IAM policy to the IAM Group
resource "aws_iam_policy" "ec2_policy" {
  name = "EC2FullAccessForDataAnalytics"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ec2:*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name = "S3AccessForDataAnalytics"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListBucket"],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action   = ["s3:GetObject", "s3:PutObject"],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group_membership" "analytics_team" {
  name = "data-analytics-group-membership"
  users = [
    aws_iam_user.company_A_analytics.name,
    aws_iam_user.company_B_analytics.name,
  ]
  group = aws_iam_group.data_analytics_group.name
}

resource "aws_iam_user" "analytics_administrator" {
  name = "administrator_A"
}

resource "aws_iam_group" "admin_group" {
  name = "analytics-admin-A"
}

resource "aws_iam_group_policy_attachment" "admin_access" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  group      = aws_iam_group.admin_group.name
}

resource "aws_iam_group_membership" "analytics_admin" {
  name = "analytics-admin-group-membership"
  users = [
    aws_iam_user.analytics_administrator.name,
  ]
  group = aws_iam_group.admin_group.name
}

resource "aws_iam_group_policy_attachment" "data_analytics_ec2_policy" {
  group      = aws_iam_group.data_analytics_group.name
  policy_arn = aws_iam_policy.ec2_policy.arn
  depends_on = [aws_iam_policy.ec2_policy]
}

resource "aws_iam_group_policy_attachment" "data_analytics_s3_policy" {
  group      = aws_iam_group.data_analytics_group.name
  policy_arn = aws_iam_policy.s3_policy.arn
  depends_on = [aws_iam_policy.s3_policy]
}

