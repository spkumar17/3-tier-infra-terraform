output "lb_sg_id" {
    description = "output of loadbalancer sercurity group id"
    value =aws_security_group.alb_sg.id
}