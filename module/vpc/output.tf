output "subnet_ids" {
    description = "security group id"
    value = [aws_subnet.subnet1_public.id, aws_subnet.subnet2_public.id]
}
output "sg" {
    description = "security group id"
    value = aws_default_security_group.default_security_group.id
}
