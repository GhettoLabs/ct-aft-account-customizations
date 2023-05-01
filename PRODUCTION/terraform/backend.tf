terraform {
  backend "s3" {
    region         = "us-west-2"
    bucket         = "vpc-leaddevopsengineer-terraform-state"
    dynamodb_table = "remote-state-lock-leaddevopsengineer-vpc"
    encrypt        = true
    key            = "leaddevopsengineer/vpc-us-west-2.tfstate"
  }
}

