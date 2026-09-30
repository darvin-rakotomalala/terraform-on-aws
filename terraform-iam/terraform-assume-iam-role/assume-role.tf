### My Account_ID ###
data "aws_caller_identity" "darvin_account" {}

### USER-ADMIN ACCOUNT ###
resource "aws_iam_role" "admin_full_access_s3" {
  name = "S3FullAccess-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "AWS" : "arn:aws:iam::${data.aws_caller_identity.darvin_account.account_id}:user/darvin-admin" }
    }]
  })
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccess-policy"
  description = "Allows full access s3"
  policy      = file("role_permissions_policy.json")
}

resource "aws_iam_policy_attachment" "s3_full_access" {
  name       = "Full access s3 policy to role"
  roles      = ["${aws_iam_role.admin_full_access_s3.name}"]
  policy_arn = aws_iam_policy.s3_full_access.arn
}

### TF-USER ACCOUNT ###
resource "aws_iam_user" "tf_user" {
  name = "tf-user"
  path = "/" # Optional: organize users with a path
  tags = {
    name = "tf-user"
  }
}

resource "aws_iam_user_login_profile" "tf_user_login" {
  user                    = aws_iam_user.tf_user.name
  password_reset_required = true
}

resource "local_file" "user_login_file" {
  filename = "tf_user_login.txt"
  content  = <<-EOT
    IAM User Logine profile
    Username: ${aws_iam_user.tf_user.name}
    Password: ${aws_iam_user_login_profile.tf_user_login.password}
  EOT
}

output "local_password" {
  value     = aws_iam_user_login_profile.tf_user_login.password
  sensitive = true
}

resource "aws_iam_policy" "admin_s3" {
  name        = "AssumeRoleAdmin_s3"
  description = "Allow assuming admin_s3 role"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::${data.aws_caller_identity.darvin_account.account_id}:role/${aws_iam_role.admin_full_access_s3.name}"
    }]
  })
  depends_on = [aws_iam_role.admin_full_access_s3]
}

resource "aws_iam_user_policy_attachment" "admin_s3" {
  user       = aws_iam_user.tf_user.name
  policy_arn = aws_iam_policy.admin_s3.arn
}
