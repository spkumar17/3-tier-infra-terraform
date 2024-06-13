resource "aws_launch_template" "launch_template" {
    name_prefix   = "launch_template"

    image_id = var.image_id
    instance_type = var.instance_type
    monitoring {
    enabled = true
    }

    network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = var.privatesubnet1a_id # Replace with your subnet ID
    security_groups             = [var.asg_sg_id]# security group ID
    }
    iam_instance_profile {
    name =var.aws_iam_instance_profile
    }

    tags = {
    Name = var.instance_name
    }

}

