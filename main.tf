terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region  = "us-east-1"
  profile = "bia"
}

resource "aws_instance" "biaTF" {
  ami           = "ami-0b72123ee41605393"
  instance_type = "t3.micro"
  security_groups = ["sg-0547e898e74a08245","sg-0a145f8bdda4ff32d"]
  subnet_id = 	"subnet-00869f3ae5c047fa9"
  tags = {
      Name = "Bia-terraform-app"
      App = "BIA"
      Origem = "Terraform"
    }

  }