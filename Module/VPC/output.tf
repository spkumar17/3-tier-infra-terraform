output "region" {
  value = var.region
}
output "project_name" {
    value = var.project_name
}


# output "vpc_cidr_block" {
#   value = var.vpc_cidr_block
# }

# output "pubsub1a_cidr_block" {
#   value = var.pubsub1a_cidr_block
# }

# output "pubsub1b_cidr_block" {
#   value = var.pubsub1b_cidr_block
# }

# output "prisub1a_cidr_block" {
#   value = var.prisub1a_cidr_block
# }

# output "prisub1b_cidr_block" {
#   value = var.prisub1b_cidr_block
# }

# output "secsub1a_cidr_block" {
#   value = var.secsub1a_cidr_block
# }

# output "secsub1b_cidr_block" {
#   value = var.secsub1b_cidr_block
# }

output "igw" {
    value = aws_internet_gateway.igw
}

output "vpc_id"{
    value=aws_vpc.myvpc.id
}
output "publicsubnet1a_id"{
    value=aws_subnet.pubsubnet1a.id

}
output "publicsubnet1b_id"{
    value=aws_subnet.pubsubnet1b.id

}
output "privatesubnet1a_id"{
    value=aws_subnet.prisubnet1a.id
}

output "privatesubnet1b_id" {
  value = aws_subnet.prisubnet1b.id
}
output "securesubnet1a_id" {
  value = aws_subnet.secsubnet1a.id
}
output "securesubnet1b_id" {
    value= aws_subnet.secsubnet1b.id 
  
}