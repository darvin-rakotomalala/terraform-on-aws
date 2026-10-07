variable "zip_python_lambda_code" {
  type        = map(string)
  description = "Name of the Python file"
  default = {
    name = "index"
  }
}

variable "terraform_lambda_iam_role" {
  type        = map(string)
  description = "aws_iam_role - terraform_lambda_iam_role variables"
  default = {
    name               = "Lambda-from-terraform"
    assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
  }
}

variable "iam_policy_for_lambda" {
  type        = map(string)
  description = "IAM policy for lambda"
  default = {
    description = "IAM policy - created by Terraform"
    policy      = <<EOF
        {
        "Version": "2012-10-17",
        "Statement": [
                {
                    "Action": [
                        "logs:CreateLogGroup",
                        "logs:CreateLogStream",
                        "logs:PutLogEvents"
                    ],
                        "Resource": "arn:aws:logs:*:*:*",
                        "Effect": "Allow"
                }
            ]
        }
        EOF
  }
}

variable "terraform_lambda" {
  type        = map(string)
  description = "Variables for lambda"
  default = {
    name    = "Lambda_Terraform"
    runtime = "python3.13"
    handler = "index.lambda_handler"
  }
}
