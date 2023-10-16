# creating iam role
resource "aws_iam_role" "lambda_role" {
  name               = var.aws_iam_role
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

  tags = {
    tag-key = "tag-value1"
  }
}

data "aws_iam_policy" "example" {
  name = var.secretpolicy
}

#creating iam policy
resource "aws_iam_policy" "lambda_policy" {
  name        = var.aws_iam_policy
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:*",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
#creating role_polciy_attachment
resource "aws_iam_role_policy_attachment" "lambda_policy_role_attachment1" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
resource "aws_iam_role_policy_attachment" "lambda_policy_role_attachment2" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = data.aws_iam_policy.example.arn
}
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_vpc_access_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

#zipping python file 
data "archive_file" "lambda_archive_file" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/hello.zip"
}

#creating lambda function
resource "aws_lambda_function" "lambda_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/python/hello.zip"
  function_name = var.aws_lambda_function
  role          = aws_iam_role.lambda_role.arn
  handler       = var.aws_lambda_function_handler
  source_code_hash = data.archive_file.lambda_archive_file.output_base64sha256
  runtime = "python3.9"
  timeout = 10
  depends_on = [aws_iam_role_policy_attachment.lambda_policy_role_attachment1, aws_iam_role_policy_attachment.lambda_policy_role_attachment2 ]
  vpc_config {
   subnet_ids         = [var.subnet_ids] # Use the subnet ID(s) you defined
   security_group_ids = [var.sgname]1cify your security group(s)
  }
   environment {
    variables = {
      SECRET_NAME= var.secretname
  }
}
