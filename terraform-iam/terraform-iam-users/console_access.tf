# create AWS IAM users with console access
resource "aws_iam_user" "console_user" {
  name = "my-console-user"
  path = "/" # Optional: organize users with a path
}

resource "aws_iam_user_login_profile" "console_user_login" {
  user                    = aws_iam_user.console_user.name
  password_reset_required = true
}

resource "local_file" "user_login_file" {
  filename = "tf_user_login_file.txt"
  content  = <<-EOT
    IAM User Logine profile
    Username: ${aws_iam_user.console_user.name}
    Password: ${aws_iam_user_login_profile.console_user_login.password}
  EOT
}

output "local_password" {
  value     = aws_iam_user_login_profile.console_user_login.password
  sensitive = true
}

# Example: Attaching a managed policy directly to the user
resource "aws_iam_user_policy_attachment" "console_user_admin_policy" {
  user       = aws_iam_user.console_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Example: Granting admin access
}

# Alternative: Add user to a group with policies
resource "aws_iam_group" "console_users_group" {
  name = "ConsoleUsers"
}

resource "aws_iam_group_membership" "add_user_to_group" {
  name  = "console-user-membership"
  group = aws_iam_group.console_users_group.name
  users = [aws_iam_user.console_user.name]
}

resource "aws_iam_group_policy_attachment" "console_group_policy" {
  group      = aws_iam_group.console_users_group.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess" # Example: Granting power user access
}
