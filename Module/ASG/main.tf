resource "aws_launch_template" "launch_template" {
    name_prefix   = "${var.project_name}-launch_template"
    image_id = var.image_id
    instance_type = var.instance_type
    key_name = "ssm"
    monitoring {
        enabled = true
    }

    network_interfaces {
        associate_public_ip_address = false
        device_index                = 0  # need to add Unique index for each interface
        network_card_index          = 0  # need to add Unique index for each interface
        subnet_id                   = var.privatesubnet1a_id #subnet of 1 frist az ID
        security_groups             = [var.asg_sg_id]# security group ID
    }
    /*
    network_interfaces {
        associate_public_ip_address = false
        device_index                = 1  # need to add Unique index for each interface
        network_card_index          = 1  # need to add Unique index for each interface 
        subnet_id                   = var.privatesubnet1b_id #subnet of secound az ID
        security_groups             = [var.asg_sg_id]# security group ID
    }*/
    iam_instance_profile {
        name =var.aws_iam_instance_profile
        }
    
    user_data = base64encode(templatefile("./module/ASG/userdata.sh.tpl", { MYSQL_URL={var.MYSQL_URL} } ))
    tags = {
        Name = var.instance_name
    }

}


resource "aws_autoscaling_group" "autoscaling_group" {
    name                      = "${var.project_name}-asg"
    max_size                  = var.max_size
    min_size                  = var.min_size
    health_check_grace_period = var.health_check_grace_period 
    health_check_type         = var.health_check_type
    desired_capacity          = var.desired_capacity
    force_delete              = true
    vpc_zone_identifier       = [var.privatesubnet1a_id,var.privatesubnet1b_id]



    launch_template {
        id      = aws_launch_template.launch_template.id
        version = aws_launch_template.launch_template.latest_version
        }
    lifecycle {
        create_before_destroy = true
    }


}
# scale up policy
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "${var.project_name}-asg-scale-up"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1" #increasing instance by 1 
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}


# scale up alarm
# alarm will trigger the ASG policy (scale/down) based on the metric (CPUUtilization), comparison_operator, threshold
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-up-alarm"
  alarm_description   = "asg-scale-up-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80" # New instance will be created once CPU utilization is higher than 80 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling_group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_up.arn]
}

# scale down policy
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "${var.project_name}-asg-scale-down"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1" # decreasing instance by 1 
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

# scale down alarm
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name          = "${var.project_name}-asg-scale-down-alarm"
  alarm_description   = "asg-scale-down-cpu-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30" # Instance will scale down when CPU utilization is lower than 30 %
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling_group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scale_down.arn]
}