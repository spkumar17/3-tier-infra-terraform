# infra_with_terraform
# infra_with_terraform


 egress {
    description     = "Allow outbound to RDS"
    from_port       = 3306               
    to_port         = 3306               
    protocol        = "tcp"
    security_groups = [aws_security_group.rds_sg.id]  # Security group of your RDS instance
  }


#need to search
how to connect rds to ec2 using rds endpoints
how to add userdata from terraform script
how to use secrets manager for rds

