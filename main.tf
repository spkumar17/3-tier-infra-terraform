module "VPC" {
    source = "./module/VPC"
    region = "us-east-1"

    vpc_cidr_block = "10.0.0.0/16"

    pubsub1a_cidr_block="10.0.1.0/24"

    pubsub1b_cidr_block="10.0.2.0/24"

    project_name="3tierDeployment"

    prisub1a_cidr_block="10.0.3.0/24"
    prisub1b_cidr_block="10.0.4.0/24"
    secsub1a_cidr_block ="10.0.5.0/24"
    secsub1b_cidr_block="10.0.6.0/24"

}

module "ALB" {
    source = "./module/ALB"
    publicsubnet1a_id = module.VPC.publicsubnet1a_id
    publicsubnet1b_id = module.VPC.privatesubnet1b_id
    project_name=module.VPC.project_name
    vpc_id        = module.VPC.vpc_id
    alb_sg_id = module.Resources.alb_sg_id

}


module "Resources" {
    source = "./module/Resources"
    vpc_id        = module.VPC.vpc_id
}

module "ASG" {

    source = "./module/ASG"
    image_id ="ami-08d6190e60b833cc4"
    instance_type = "t2.micro"
    instance_name = "mainservers"
    max_size="4"
    min_size="2"
    health_check_grace_period="300"
    health_check_type="ELB"
    desired_capacity="2"
    asg_sg_id=module.Resources.asg_sg_id
    privatesubnet1a_id=module.VPC.privatesubnet1a_id
    privatesubnet1b_id=module.VPC.privatesubnet1b_id
    aws_iam_instance_profile=module.Resources.aws_iam_instance_profile_name
    project_name=module.VPC.project_name
    db_instance_endpoint=module.RDS.db_instance_endpoint



}
module "RDS" {
    source = "./module/RDS"
    allocated_storage="20"
    storage_type = "gp3"
    engine = "mysql"
    instance_class="db.t3.medium"
    engine_version="8.0"
    username="admin"
    password ="Devops#21"
    backup_retention_period = "10"
    backup_window           = "00:00-03:00"
    maintenance_window      = "sun:05:00-sun:06:00"
    securesubnet1a_id=module.VPC.securesubnet1a_id
    securesubnet1b_id=module.VPC.securesubnet1b_id
    rds_sg_id=module.Resources.rds_sg_id




  
}