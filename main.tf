terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0" # Use an appropriate version constraint

    }
  }
}

# Replace this with your desired AWS region
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  # Other optional configuration settings can be added here if needed
}

module "aws_lambda" {
  source                      = "./module/lambda"
  aws_iam_role                = var.aws_iam_role
  aws_iam_policy              = var.aws_iam_policy
  aws_lambda_function         = var.aws_lambda_function
  aws_lambda_function_handler = var.aws_lambda_function_handler
  secretname                  = var.secretname
  secretpolicy                = module.secret_manager.secretpolicy
  depends_on                  = [module.secret_manager]
  subnet1_cidr                = [module.vpc.subnet_ids]
  sgname                      = [module.vpc.sgname]
}

module "secret_manager" {
  source       = "./module/secretmanager"
  secretname   = var.secretname
  secretpolicy = var.secretpolicy
}

module "vpc" {
  source       = "./module/vpc"

}


