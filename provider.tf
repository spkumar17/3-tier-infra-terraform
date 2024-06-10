terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = module.myvpc.region
}
#Backend Configration

terraform {
  backend "s3" {
    bucket         = "tfstatefile-s3-store" # Backet name (Unique)
    key            = "terraform.tfstate" # name of the file in Bucket
    region         = "us-east-1" 
  }
}