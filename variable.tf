variable "lambda_role" {
  type        = string
  description = "creating iam role for lambda function"
  default     = "inventory_iam_role1"
}
variable "lambda_policy" {
  type        = string
  description = "creating iam policy for lambda function"
  default     = "inventory_iam_policy1"
}
variable "lambda_function" {
  type        = string
  description = "creating lambda function"
  default     = "inventory_lambda_function_name"
}

variable "lambda_function_handler" {
  type        = string
  description = "creating lambda function"
  default     = "lambda-handler.lambda_handler"
}

variable "aws_region" {
  type        = string
  description = "creating lambda function in this region"
  default     = "eu-west-2"
}

variable "aws_access_key" {
  type        = string
  description = "creating lambda function"
  default     = "AKIA2KIPWTT5NEIHTJYO"
}

variable "aws_secret_key" {
  type        = string
  description = "creating lambda function"
  default     = "SUdH96g/3he7BGAzF90QA5w/SbiHjr4QHM1iOZD7"
}

#vpc variables
# variable "vpc_cidr" {
#   type        = string
#   description = "vpc cidr block"
#   default     = "10.0.0.0/16"
# }

# variable "public_subnet_az1_cidr" {
#   type        = string
#   description = "public subnet cidr for az1"
#   default     = "10.0.2.0/24"
# }
#variable "security_group_id" {}

variable "demo-subnet1" {
  type        = string
  description = "public subnet cidr for az2"
  default     = "10.0.0.0/24"
}

variable "demo-subnet2" {
  type        = string
  description = "private subnet cidr for az2"
  default     = "10.0.1.0/24"
}
variable "secret_name" {
  type        = string
  description = "This is the secret_key for aws account"
  default = "invo-12345678100"
}

variable "secret_policy" {
  type        = string
  description = "This is the secret_key for aws account"
  default     = "secretpolicy123"
}


