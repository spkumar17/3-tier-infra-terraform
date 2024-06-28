output "alb_sg_id" {
    description = "output of loadbalancer security group id"
    value =aws_security_group.alb_sg.id
}
output "asg_sg_id" {
    description = "output of auto scaling group security group id"
    value = aws_security_group.asg_sg.id

}
output "rds_sg_id" {
    description = "output of RDS security group id "
    value = aws_security_group.rds_sg.id

}
output "ssm_endpoint_sg_id" {
    value = aws_security_group.ssm_endpoint_sg.id
}
output "aws_iam_instance_profile_name" {
    description = "name of ec2 iam instace profile"
    value =aws_iam_instance_profile.my_launch_template_instance_profile.name
}