terraform {
  required_version = ">= 0.12"
  required_providers {
   aws = {
    source = "hashicorp/aws"
    version = "~>4.54.0"
   }
  }
  backend s3 {
    bucket = "gordon-terraformstate"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
  
  
}