output "load_balancer_arn" {
    value =aws_lb.alb.arn
}
output "alb_target_group_arn" {
    value =aws_lb_target_group.alb_target_group.arn
}