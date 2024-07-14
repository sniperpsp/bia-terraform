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
  ami           = var.ami
  instance_type = "t3.micro"
  security_groups = [aws_security_group.SG-Terraform.id]
  subnet_id = 	"subnet-00869f3ae5c047fa9"
  tags = {
      Name = var.instance_name
      App = "BIA"
      Origem = "Terraform"
    }
    root_block_device {
      volume_size = 16
      volume_type = "gp3"
      encrypted = false

    }
  }
  resource "aws_security_group" "SG-Terraform" {
    name = "SG-Terraform"
    description = "SG-Terraform"
    vpc_id = "vpc-0a992188b5122107a"

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitindo acesso a porta 22"
    }
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitindo acesso a porta http"
    }
    ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitindo acesso a porta https"
    }
    ingress {
      from_port = 3001
      to_port = 3001
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Permitindo acesso a porta 3001 para o mundo"
    }
    tags = {
      Name = "SG-Terraform"
      Description = "SG-Terraform"
    } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitindo saida para o mundo"
  }
  
  }

#Comando para mudar a variavel do variables somente na execução do apply ( terraform apply -var 'instance_name=biaTF-2' )
#Comando para mudar a variavel do variables e no momento da criação da EC2 ( terraform apply -var 'instance_name=biaTF-2' -var 'ami=ami-0b72123ee41605393' )
#Comando para mostrar  informaçes sobre recurso especifico ( terraform state show aws_security_group.SG-Terraform )
#Comando para mostrar  informaçes sobre recurso especifico ( terraform state show aws_instance.biaTF )