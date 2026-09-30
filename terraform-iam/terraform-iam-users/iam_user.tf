# Creating multiple IAM users
variable "username" {
  type    = list(string)
  default = ["tf-tucker", "tf-annie", "tf-josh"]
}

resource "aws_iam_user" "demo" {
  count = length(var.username)
  name  = element(var.username, count.index)
}

output "user_arn" {
  value = aws_iam_user.demo.*.arn
}

/*
# An alternative to using length and element is for_each.
resource "aws_iam_user" "example" {
  for_each = toset(["tucker", "annie", "josh"])
  name     = each.value
}
*/

resource "aws_iam_user_policy" "newemp_policy" {
  count      = length(var.username)
  name       = "tf-policy"
  user       = element(var.username, count.index)
  policy     = <<EOF
    {
      "Version": "2012-10-17",  
      "Statement": [   
        { 
          "Effect": "Allow",      
          "Action": [        
              "ec2:Describe*"      
           ],      
          "Resource": "*"    
        }  
      ]}
  EOF
  depends_on = [aws_iam_user.demo]
}
