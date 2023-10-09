output "secretpolicy" {
  description = "secret policy"
  value       = aws_iam_policy.example.arn
}