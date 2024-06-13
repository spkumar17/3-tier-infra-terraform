output "alb_sg_id" {
    description = "output of loadbalancer sercurity group id"
    value =aws_security_group.alb_sg.id
}
output "asg_sg_id" {
    description = "output of auto scaling group sercurity group id"
    value = aws_security_group.asg_sg.id

}
output "aws_iam_instance_profile_name" {
    description = "name of ec2 iam instace profile"
    value =aws_iam_instance_profile.my_launch_template_instance_profile.name
}