variable "key_name" {
  type        = string
  description = "SSH key name"
}

variable "key_path" {
  type        = string
  description = "Path to private key file"
}

variable "region" {
  type        = string
  description = "AWS region to deploy in"
  default     = "us-east-1"
}

variable "ami" {
  type        = string
  description = "AMI id"
  default     = "ami-08a52ddb321b32a8c"
}

variable "instance_type" {
  type        = string
  description = "The instance type"
  default     = "t2.micro"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC cidr block"
  default     = "10.0.0.0/24"
}

variable "subnets" {
  type        = map(any)
  description = "A map of availability zones to subnet cidr"
  default = {
    us-east-1a = "10.0.0.0/25"
    us-east-1b = "10.0.0.128/25"
  }
}