﻿# infra_with_terraform
# infra_with_terraform


 egress {
    description     = "Allow outbound to RDS"
    from_port       = 3306               
    to_port         = 3306               
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_sg.id]  # Security group of your RDS instance
  }
