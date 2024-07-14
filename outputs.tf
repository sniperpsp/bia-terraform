output "instance_id" {
  description = "ID da EC2"
  value = aws_instance.biaTF.id
}

output "instance_type" {
  description = "Tipo da EC2"
  value = aws_instance.biaTF.instance_type
}

output "security_groups" {
  description = "Grupos de segurança da EC2"
  value = aws_instance.biaTF.security_groups
}

output "ami" {
  description = "AMI da EC2"
  value = aws_instance.biaTF.ami
}

 output "private_ip" {
   description = "IP privado da EC2"
   value = aws_instance.biaTF.private_ip
 }
 
 output "instace_public_ip" {
   description = "IP pblico da EC2"
   value = aws_instance.biaTF.public_ip
 }