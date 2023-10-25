# creating iam role
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = var.lambda_role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  
}

#creating iam policy
resource "aws_iam_policy" "lambda_policy" {
  name        = var.lambda_policy
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

resource "aws_iam_policy" "secret_policy" {
  name       = var.secret_policy # Add a name for your policy
  //secret_arn = aws_secretsmanager_secret.mongodb_secret.arn
  policy     = jsonencode({
    Version  = "2012-10-17",
    Statement = [
      {
        Sid       = "Stmt1696495460910",
        Action    = "secretsmanager:*",
        Effect    = "Allow",
        Resource  = "*"
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_vpc_access_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
#creating role_polciy_attachment
resource "aws_iam_role_policy_attachment" "lambda_policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
resource "aws_iam_role_policy_attachment" "secret_policy_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.secret_policy.arn
}
data "aws_secretsmanager_secret" "examplesecret" {
  name = var.secret_name
}

#zipping python file 
data "archive_file" "lambda_archive_file" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/lambda_handler.zip"
}

#creating lambda function
resource "aws_lambda_function" "lambda_function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "${path.module}/python/lambda_handler.zip"
  function_name = var.lambda_function
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_function_handler
  source_code_hash = data.archive_file.lambda_archive_file.output_base64sha256
  runtime = "python3.10"
  timeout = 10
  depends_on = [aws_iam_role_policy_attachment.lambda_policy_role_attachment, aws_iam_role_policy_attachment.secret_policy_role_attachment, aws_iam_role_policy_attachment.iam_role_policy_attachment_lambda_vpc_access_execution]
  vpc_config {
  subnet_ids         = [var.subnet1-id, var.subnet2-id] # Use the subnet ID(s) you defined
  security_group_ids = [var.security_group_id] # Specify your security group(s)
  }
  environment {
  variables = {
    SECRET_NAME= var.secret_name
  }
  }
}
