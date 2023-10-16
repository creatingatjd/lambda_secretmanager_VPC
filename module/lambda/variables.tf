variable "aws_iam_role" {
  type = string
  description = "creating iam role for lambda function"
}
variable "aws_iam_policy" {
  type = string
  description = "creating iam policy for lambda function"
}
variable "aws_lambda_function" {
  type = string
  description = "creating lambda function"
}

variable "aws_lambda_function_handler" {
  type = string
  description = "creating lambda function"
}
variable "secretname" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "secretpolicy" {
    type = string
    description = "This is the secret_key for aws account"
}

variable "subnet_ids" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "sgname" {
    type = string
    description = "This is the secret_key for aws account"
}





