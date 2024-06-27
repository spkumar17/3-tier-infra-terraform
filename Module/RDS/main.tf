resource "aws_db_subnet_group" "db_subnet_group" {
    name       = "db_subnet_group"
    subnet_ids = [var.securesubnet1a_id,var.securesubnet1b_id]  # subnet IDs for DB 

    tags = {
        Name = "db_subnet_group"
    }
}
resource "aws_db_instance" "db_instance" {
    db_name = "DBinstance"
    allocated_storage    = var.allocated_storage
    storage_type         = var.storage_type
    engine               = var.engine    #"mysql" or postgras
    engine_version       = var.engine_version
    instance_class       = var.instance_class
    username             = var.username
    password             = var.password
    db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
    vpc_security_group_ids = [var.rds_sg_id]

    multi_az             = true
    skip_final_snapshot    = true  # this will skip the final snapshot after deleting the rds


    # Additional configurations
    backup_retention_period = var.backup_retention_period
    backup_window           = var.backup_window
    maintenance_window      = var.maintenance_window

    tags = {
        Name ="RDS_db_instance"
    }
}

