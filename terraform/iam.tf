terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.7.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "aws" {
   region  = var.aws_region
}

module "iam" {
  source                = "./modules/aws-iam"
  entity_name           = var.entity_name
  aws_account_id        = var.aws_account_id
  aws_region            = var.aws_region
}
