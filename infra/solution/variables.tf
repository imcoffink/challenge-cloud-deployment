variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "AWS Region"
}

variable "vpc_block" {
  type = string
  default = "10.0.0.0/16"
  description = "VPC CIDR Block"
}

variable "subnet1_block" {
  type = string
  default = "10.0.10.0/24"
  description = "Subnet1 CIDR Block"
}

variable "subnet2_block" {
  type = string
  default = "10.0.11.0/24"
  description = "Subnet2 CIDR Block"
}

variable "app_db_name" {
  type = string
  default = "DefaultDbName"
  description = "Application DB Name"
}

variable "app_db_user" {
  type = string
  default = "DefaultDbUser"
  description = "Application DB User"
}

variable "app_db_password" {
  type = string
  default = "ChangeMe"
  description = "Application DB Password"
}

variable "app_name" {
  type = string
  default = "DefaultAppName"
  description = "Application Name"
}

variable "app_image" {
  type = string
  default = "DefaultAppImage"
  description = "Application Image"
}

variable "service_name" {
  type = string
  default = "DefaultSvcName"
  description = "Container Service Name"
}
