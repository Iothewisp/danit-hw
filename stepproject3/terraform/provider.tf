terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = "default" # использует твой локальный профиль из ~/.aws/credentials
}
