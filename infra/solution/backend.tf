terraform {
  backend "s3" {
    bucket = "aws-challenge-terraform-states"
    key = "challenge.tfstate"
    region = "eu-central-1"
  }
}
