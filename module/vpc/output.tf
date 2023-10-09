#output "vpc_cidr"{
 #   description = "value of subnet1"
  #  value = aws_vpc.demo-vpc
#}
output "subnet1_cidr"{
    description = "value of subnet1"
    value = aws_subnet.demo-subnet1.id
}
output "subnet2_cidr"{
    description = "value of subnet1"
    value = aws_subnet.demo-subnet2.id
}
output "sgname"{
    description = "value of securitygroup"
    value = aws_security_group.demo-sg.id
}
