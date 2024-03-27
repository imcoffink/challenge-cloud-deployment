terraform {
  backend "s3" {
    bucket = "challenge-iagomisko-terraform-states"
    key = "challenge.tfstate"
    region = "eu-central-1"
  }
}
