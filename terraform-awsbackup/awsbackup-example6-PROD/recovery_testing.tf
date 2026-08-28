########################################
## Recovery Testing - The final piece is making sure your backups actually work.
# Schedule regular restore tests.
########################################

# Lambda function that performs monthly restore tests
resource "aws_lambda_function" "restore_tester" {
  filename      = "restore_tester.zip"
  function_name = "backup-restore-tester"
  role          = aws_iam_role.restore_tester_role.arn
  handler       = "index.handler"
  runtime       = "python3.11"
  timeout       = 900

  environment {
    variables = {
      BACKUP_VAULT  = aws_backup_vault.primary.name
      SUBNET_ID     = var.test_subnet_id
      SG_ID         = var.test_security_group_id
      SNS_TOPIC_ARN = aws_sns_topic.backup_alerts.arn
    }
  }
}

# Monthly schedule for restore testing
resource "aws_cloudwatch_event_rule" "monthly_restore_test" {
  name                = "monthly-restore-test"
  schedule_expression = "cron(0 6 1 * ? *)" # 1st of each month at 6 AM
}

resource "aws_cloudwatch_event_target" "restore_test" {
  rule      = aws_cloudwatch_event_rule.monthly_restore_test.name
  target_id = "trigger-restore-test"
  arn       = aws_lambda_function.restore_tester.arn
}
