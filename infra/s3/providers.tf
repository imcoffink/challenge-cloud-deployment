### Providers

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4"
    }
  }
}

provider "aws" {
  profile = "default"
  region = "eu-central-1"
}

