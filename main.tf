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
  subnet_id = "subnet-00869f3ae5c047fa9"
  
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

  user_data = <<-EOF
    #!/bin/bash
    #Instalar Docker e Git
    yum update -y
    sudo yum install git -y
    sudo yum install docker -y
    sudo usermod -a -G docker ec2-user
    sudo usermod -a -G docker ssm-user
    id ec2-user ssm-user
    sudo newgrp docker

    #Instalar docker-compose
    wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) 
    sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/local/bin/docker-compose
    sudo chmod -v +x /usr/local/bin/docker-compose

    #Ativar docker
    sudo systemctl enable docker.service
    sudo systemctl start docker.service

    #Adicionar swap
    sudo dd if=/dev/zero of=/swapfile bs=128M count=32
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

    #Adicionar node 18 e npm
    sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
    sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
  EOF
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
    from_port = 3002
    to_port = 3002
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