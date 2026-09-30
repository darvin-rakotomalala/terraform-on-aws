# Create IAM User
resource "aws_iam_user" "tf_user_demo" {
  name = "tf_user_demo"

  tags = {
    creator = "tf_user_demo"
  }
}

# Create access key ID and secret key 
resource "aws_iam_access_key" "tf_user_demo_access_key" {
  user = aws_iam_user.tf_user_demo.name
}

output "access_key_id" {
  value     = aws_iam_access_key.tf_user_demo_access_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.tf_user_demo_access_key.secret
  sensitive = true
}

locals {
  tf_user_demo_keys_csv = "access_key,secret_key\n${aws_iam_access_key.tf_user_demo_access_key.id},${aws_iam_access_key.tf_user_demo_access_key.secret}"
}

resource "local_file" "tf_user_demo_keys" {
  content  = local.tf_user_demo_keys_csv
  filename = "tf_user_demo-keys.csv"
}

# Create access key ID and secret key in TXT file
resource "aws_iam_access_key" "access_key_for_tf_user_demo" {
  user = aws_iam_user.tf_user_demo.name
}

resource "local_file" "company_access_key_file" {
  filename = "tf_user_demo_access_key.txt"
  content  = <<-EOT
    IAM User Credentials : ${aws_iam_user.tf_user_demo.name}
    Access Key: ${aws_iam_access_key.access_key_for_tf_user_demo.id}
    Secret Key: ${aws_iam_access_key.access_key_for_tf_user_demo.secret}
  EOT
}

# Create a User Group
resource "aws_iam_group" "tf-developers" {
  name = "tf-developers"
}

resource "aws_iam_group_membership" "tf_user_demo_membership" {
  name  = aws_iam_user.tf_user_demo.name
  users = [aws_iam_user.tf_user_demo.name]
  group = aws_iam_group.tf-developers.name
}

# Create AWS-managed policy and Custom policy And attach user group
# rds full
data "aws_iam_policy" "rds_full_access" {
  arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# ec2 custom
data "aws_iam_policy_document" "ec2_instance_actions" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
    ]

    resources = [
      "arn:aws:ec2:*:*:instance/*",
    ]
  }
}

resource "aws_iam_policy" "ec2_instance_actions" {
  name   = "ec2_instance_actions"
  policy = data.aws_iam_policy_document.ec2_instance_actions.json
}

# Attached AWS managed and custom Policies for the User group
resource "aws_iam_group_policy_attachment" "tf-developers_rds_full_access" {
  policy_arn = data.aws_iam_policy.rds_full_access.arn
  group      = aws_iam_group.tf-developers.name
}

resource "aws_iam_group_policy_attachment" "developers_ec2_instance_actions" {
  policy_arn = aws_iam_policy.ec2_instance_actions.arn
  group      = aws_iam_group.tf-developers.name
}

# Create IAM Role
resource "aws_iam_role" "tf-cloudwatchagent-role" {
  name = "tf-cloudwatchagent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# attache role policies
resource "aws_iam_role_policy_attachment" "my_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" # Update with your desired policy
  role       = aws_iam_role.tf-cloudwatchagent-role.name
}
