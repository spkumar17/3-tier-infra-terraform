# crating 

resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.publicsubnet1a_id,var.publicsubnet1b_id]

  enable_deletion_protection = true



  tags = {
    name = "${var.project_name}-alb"

  }
}

