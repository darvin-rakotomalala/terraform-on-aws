# Define user and password
resource "aws_iam_user" "demo_user" {
  name = "tf-demo-user"
}

resource "aws_iam_user_login_profile" "demo_user_login_profile" {
  user                    = aws_iam_user.demo_user.name
  password_reset_required = true
}

resource "local_file" "user_login_file" {
  filename = "tf_user_login_file.txt"
  content  = <<-EOT
    IAM User Logine profile
    Username: ${aws_iam_user.demo_user.name}
    Password: ${aws_iam_user_login_profile.demo_user_login_profile.password}
  EOT
}

output "local_password" {
  value     = aws_iam_user_login_profile.demo_user_login_profile.password
  sensitive = true
}

# Creating an inline IAM policy and attach to user
resource "aws_iam_user_policy" "s3_list_only_policy" {
  name = "S3ListOnlyPolicy"
  user = aws_iam_user.demo_user.name

  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [{
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets"
            ],
            "Resource": "*"
        }]
    }
    EOF
}

# Creating standalone IAM policies
# 1. Using the Terraform jsonencode function
resource "aws_iam_policy" "s3_read_only_policy" {
  name = "S3ReadOnlyPolicy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:ListBucket",
        "s3:GetObject"
      ]
      Resource = "*"
    }]
  })
}

# attach the standalone IAM policy to a user
resource "aws_iam_user_policy_attachment" "demo_user_attach_s3_read_only_policy" {
  user       = aws_iam_user.demo_user.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

# 2. Using the Terraform file function
resource "aws_iam_policy" "s3_delete_only_policy" {
  name   = "S3DeleteOnlyPolicy"
  policy = file("policies_function.json")
}

# 3. Using a Terraform aws_iam_policy_document data resource
data "aws_iam_policy_document" "s3_write_only_policy_document" {
  statement {
    sid = "1"
    actions = [
      "s3:PutObject",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "s3_write_only_policy" {
  name   = "S3WriteOnlyPolicy"
  policy = data.aws_iam_policy_document.s3_write_only_policy_document.json
}

# attach an AWS-managed policy to a user
data "aws_iam_policy" "aws_rds_full_access_policy" {
  name = "AmazonRDSFullAccess"
}

resource "aws_iam_user_policy_attachment" "demo_user_attach_aws_rds_full_access_policy" {
  user       = aws_iam_user.demo_user.name
  policy_arn = data.aws_iam_policy.aws_rds_full_access_policy.arn
}
