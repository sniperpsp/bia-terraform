variable "instance_name" {
  description = "Nome da EC2"
  type = string
  default = "biaTF"
}

variable "ami" {
  description = "AMI da EC2"
  type = string
  default = "ami-0b72123ee41605393"
}