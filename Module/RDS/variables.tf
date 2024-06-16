
variable "securesubnet1a_id" {
    description = "db secure subnet1a"
    type = string
  
}

variable "securesubnet1b_id" {
    description = "db secure subnet1b"
    type = string
  
}
variable "allocated_storage" {
    description = "storage space allocated to the instance"
    type=string
  
}

variable "storage_type" {
    description = "storage type allocated to the instance like gp2,gp3 etc... "
    type = string
  
}
variable "engine" {
    description = "engine that i am using #mysql or postgresql etc.... "
    type=string
  
}
variable "instance_class" {
    description = "type of the db instance that you are using "
    type = string
  
}
variable "engine_version" {
    description = "version of the engine "
    type = string
  
}
variable "username" {
    description = "username of the db "
    type = string
  
}
variable "password" {
    description = "password of the db server"
    type = string
}

variable "backup_retention_period" {
    description = "This specifies the number of days for which automated backups are retained "
    type = string
  
}
variable "backup_window" {
    description = "this is the time are daily automated backups are performed"
    #schedule this window during off-peak hours to minimize the impact on database performance.
    type = string
  
}
variable  "maintenance_window"  {
    description = "this is the time where the maintenance activity is performed weekly"
    #choose a time that will have minimal impact on your application's availability and performance.
    type = string


}   
variable "rds_sg_id" {
    description = "sg id of RDS"
    type=string
  
}