
variable "project_name" {
  description = "name of project"
  type = string

}
variable "region" {
    description = "name of the region where this infrasture is created"
    type = string
    default = "us-east-1"
}



variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


variable "pubsub1a_cidr_block" {
  description = "cidr range for publicsubnet1a "
  type = string
  default = "10.0.1.0/24"
}

variable "pubsub1b_cidr_block" {
  description = "cidr range for publicsubnet1b "
  type = string
  default = "10.0.2.0/24"
}

variable "prisub1a_cidr_block" {
  description = "cidr range for publicsubnet1b "
  type = string
  default = "10.0.3.0/24"
}

variable "prisub1b_cidr_block" {
  description = "cidr range for publicsubnet1b "
  type = string
  default = "10.0.4.0/24"
}

variable "secsub1a_cidr_block" {
  description = "cidr range for publicsubnet1b "
  type = string
  default = "10.0.5.0/24"
}

variable "secsub1b_cidr_block" {
  description = "cidr range for publicsubnet1b "
  type = string
  default = "10.0.6.0/24"
}

variable "ssm_endpoint_sg_id" {
  type=string 
}