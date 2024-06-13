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