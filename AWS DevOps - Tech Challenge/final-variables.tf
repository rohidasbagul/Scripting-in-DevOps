#aws/final-variables.tf

variable "region" {
  description = "AWS region to create VPC"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "ewebshop"
}

variable "public_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in web layer"
  default     = ["10.0.5.0/24", "10.0.7.0/24"]
}

variable "web_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in web layer"
  default     = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "app_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in app layer"
  default     = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "db_subnets_cidr_blocks" {
  description = "CIDR blocks of subnets in DB layer"
  default     = ["10.0.6.0/24", "10.0.8.0/24"]
}

variable "rds_subnet_name" {
  description = "Name of the RDS subnet group"
  default     = "ewebshop_rds_group"
}

variable "rds_storage" {
  description = "RDS storage space"
  default     = "45"
}

variable "rds_engine" {
  description = "RDS engine type"
  default     = "ewebshop_mysql"
}

variable "rds_instance_class" {
  description = "RDS instance class"
  default     = "db.x2g"
}

variable "rds_name" {
  description = "Name of the RDS"
  default     = "ewebshop_mysql_rds"
}

variable "rds_username" {
  description = "Username of the RDS"
  default     = "ewebshop_mysql"
}

variable "rds_password" {
  description = "Password of the RDS"
  default     = "QWERTy98734"
}

variable "websg_name" {
  description = "Name of security group for webservers"
  default     = "ewebshop_webserver_sg"
}

variable "web_ami" {
  description = "AMI of webservers"
  default     = "ami-0f9ce67dcf718d332"
}

variable "web_instance" {
  description = "Instance type of webservers"
  default     = "t3.2xlarge"
}

variable "webserver_name" {
  description = "Name of web servers"
  default     = ["e-webshop1", "e-webshop2"]
}

variable "lb_name" {
  description = "Name of the application load balancer"
  default     = "ewebshop-applb"
}

variable "tg_name" {
  description = "Name of the application load balancer target group"
  default     = "ewebshop-applb-tg"
}

variable "tg_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "80"
}

variable "tg_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTP"
}

variable "listener_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "443"
}

variable "listener_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTPs"
}

# Certificate ARN for HTTPS
variable "certificate_arn_user" {
  description = "Enter the certificate ARN for HTTPS"
  default     = "ewebshop"
}
