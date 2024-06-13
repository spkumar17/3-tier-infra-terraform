output "region" {
  value = var.region
}
output "project_name" {
    value = var.project_name
}

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