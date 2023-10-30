terraform {
  backend "s3" {
    bucket = "santosclaudinei-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
