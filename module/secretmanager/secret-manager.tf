resource "aws_secretsmanager_secret" "mongodb_secret" {
  name        = var.secretname # Replace with your desired secret name
  description = "MongoDB credentials"
}

resource "aws_secretsmanager_secret_version" "mongodb_secret_version" {
  secret_id     = aws_secretsmanager_secret.mongodb_secret.id
  secret_string = <<EOF
{
  "username": "username",
  "password": "password",
  "host": "your-mongodb-host",
  "port": "your-mongodb-port",
  "database": "your-mongodb-database"
}
EOF
}

resource "aws_iam_policy" "example" {
  name       = var.secretpolicy # Add a name for your policy
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
