variable "lambda_role" {
  type = string
  description = "creating iam role for lambda function"
  //default = "inventory_iam_role"
}
variable "lambda_policy" {
  type = string
  description = "creating iam policy for lambda function"
  //default =  "inventory_iam_policy"
}
variable "lambda_function" {
  type = string
  description = "creating lambda function"
  //default = "inventory_lambda_function_name"
}

variable "lambda_function_handler" {
  type = string
  description = "creating lambda function"
  //default = "hello.lambda_handler"
}
variable "secret_name" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "secret_policy" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "subnet1-id" {
  type        = string
  description = "public subnet cidr for az1"
  #default     = "10.10.1.0/24"
}

variable "subnet2-id" {
  type        = string
  description = "public subnet cidr for az2"
  #default     = "10.10.1.0/24"
}

variable "security_group_id" {
  type        = string
  description = "public subnet cidr for az2"
}

