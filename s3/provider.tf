terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 1.0.1"
}

provider "aws" {
  #   profile = "cloud_user"
  region = var.region
}
