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

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0" # Use an appropriate version constraint

    }
  }
}
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  # Replace this with your desired AWS region
  # Other optional configuration settings can be added here if needed
}
module "aws_lambda" {
  source                  = "./Modules/lambda"
  lambda_role             = var.lambda_role
  lambda_policy           = var.lambda_policy
  lambda_function         = var.lambda_function
  lambda_function_handler = var.lambda_function_handler
  secret_name             = module.secret_manager.secret_name
  secret_policy           = var.secret_policy
  security_group_id       = module.vpc.security_group_id
  subnet1-id              = module.vpc.subnet1-id
  subnet2-id              = module.vpc.subnet2-id
  depends_on              = [module.secret_manager, module.vpc]
}

module "secret_manager" {
  source      = "./Modules/secretmanager"
  secret_name = var.secret_name
}

module "vpc" {
  source       = "./Modules/vpc"
  demo-subnet1 = var.demo-subnet1
  # demo-subnet2 = var.demo-subnet2

  
}










