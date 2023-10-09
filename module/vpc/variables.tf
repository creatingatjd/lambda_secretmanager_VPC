variable "vpc_cidr" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "subnet1_cidr" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "subnet2_cidr" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "sgname" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "rt_cidr" {
    type = string
    description = "This is the secret_key for aws account"
}
variable "aws_region" {
  type        = string
  description = "creating lambda function in this specific region"
}