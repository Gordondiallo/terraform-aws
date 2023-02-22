variable "private_key" {
    type = string
    default = ""
    description = "Private Key name for EC2 instance"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "Type of EC2 instance in AWS"
  
}

variable "instance_name" {
    type = string
    default = "EC2Instance"
    description = "Name of EC2 instance"
  
}

variable "aws_region" {
    default = "us-east-1"
    type = string
    description = "AWS region where terraform resources will be created"
  
}
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.3.0/24", "10.0.4.0/24"]
}
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
    description = "CIDR for VPC "
  
}