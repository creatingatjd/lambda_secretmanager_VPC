variable "aws_iam_role" {
  type        = string
  description = "creating an iam role for lambda"
}

variable "aws_iam_policy" {
  type        = string
  description = "creating iam policy for lambda"
}

variable "aws_lambda_function" {
  type        = string
  description = "creating lambda function"
}
variable "aws_lambda_function_handler" {
  type        = string
  description = "creating aws_lambda_function_handler"
}
variable "aws_region" {
  type        = string
  description = "creating lambda function in this specific region"
}

variable "aws_access_key" {
  type        = string
  description = "This is the access_key for aws account"
}
variable "aws_secret_key" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "secretname" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "secretpolicy" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "vpc_cidr" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "subnet1_cidr" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "subnet2_cidr" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "sgname" {
  type        = string
  description = "This is the secret_key for aws account"
}
variable "rt_cidr" {
  type        = string
  description = "This is the secret_key for aws account"
}
