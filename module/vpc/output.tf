# public subnet az1 id
output "subnet1-id" {
  value = aws_subnet.demo-subnet1.id
}

#public subnet az2 id
output "subnet2-id" {
  value = aws_subnet.demo-subnet2.id
}

#private subnet in az2 id
output "security_group_id" {
  value = aws_security_group.demo-sg.id
}
