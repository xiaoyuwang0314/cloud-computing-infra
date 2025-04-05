variable "region" {
  description = "AWS region to deploy resources in"
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "webapp_ami_id" {
  description = "AMI ID for the WebApp EC2 instances"
  type        = string
}

variable "mysql_ami_id" {
  description = "AMI ID for the MySQL EC2 instance"
  type        = string
}

variable "database_username" {
  description = "Username for MySQL database"
  type        = string
}

variable "database_password" {
  description = "Password for MySQL database"
  type        = string
  sensitive   = true
}

variable "webapp_secret_key" {
  description = "Secret key used by WebApp"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "My domain"
  type        = string
}