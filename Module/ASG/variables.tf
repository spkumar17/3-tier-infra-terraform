variable "image_id"{
    description = "image id"
    type= string
    default = "ami-08d6190e60b833cc4"

}    
variable "instance_type" {
    description = "type of the instance "
    type = string
    default = "t2.micro"
  
}
variable "instance_name" {
    description = "specifies the name of the instance created"
    type =string
  
}
variable "asg_sg_id" {
    description = "security group id (asg) winstances---> allow this portss"
    type = string
  
}
variable "privatesubnet1a_id" {
    description = "private subnet id az1"
    type = string
  
}
variable "privatesubnet1b_id" {
    description = "private subnet id az2"
    type = string
  
}

variable "aws_iam_instance_profile" {
    description = "name of ec2 iam instace profile "
    type=string
  
}

variable "max_size" {
    description = "max count that auto scale can increase"
    type = string
  
}
variable "min_size" {
    description = "min count that auto scalig will maintain"
    type = string
  
}
variable "health_check_grace_period" {
    description = "till this grace time no new instance will be created even of the instance is in unhealthy state"
    type = string
}
variable "health_check_type" {
    description = "based on which  type auto scale spin up or scale down the instance"
    type = string
  
}
variable "desired_capacity" {

    description = "capacity that asg maintain aat nrml times"
    type = string
  
}
variable "project_name" {
  description = "name of project"
  type = string

}