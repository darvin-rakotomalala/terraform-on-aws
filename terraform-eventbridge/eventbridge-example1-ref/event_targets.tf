#################################################
### target the Lambda
#################################################
/*
resource "aws_cloudwatch_event_target" "target_lambda" {
  arn  = aws_lambda_function.lambda.arn
  rule = aws_cloudwatch_event_rule.s3_createobject.name
}
*/

#################################################
### target the SQS queue
#################################################
/*
resource "aws_cloudwatch_event_target" "target_sqs_queue" {
  arn  = aws_sqs_queue.data_queue.arn
  rule = aws_cloudwatch_event_rule.s3_createobject.name
}
*/