output "public_ip" {
    value = aws_eip.terraform-eip.public_ip
}
output "instance-id" {
    value = aws_instance.gordon-ec2.id 
}