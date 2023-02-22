resource "tls_private_key" "gordon-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_eip" "terraform-eip" {
  instance = aws_instance.gordon-ec2.id
  vpc = true
  depends_on = [
    aws_instance.gordon-ec2
  ]
  tags = {
    Name = "Terraform-eip"
    Environment = "Testing"
    Owner = "The great gordon-DevOps"
    Created-by = "Gordon"
  }
}

resource "aws_key_pair" "gordon-key" {
    key_name = var.private_key
    public_key = tls_private_key.gordon-key.public_key_openssh
}
resource "aws_security_group" "gordon-sg" {
    name = "gordon-sg"
    vpc_id = "${aws_vpc.Gordon-vpc.id}"
    description = "Allow Gordon to access server"
ingress {
    description      = "SSH from gordon IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["${chomp(data.http.mysystemip.response_body)}/32"]
}
ingress {
    description      = "HTTP request Allow"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
}
 depends_on = [
    aws_vpc.Gordon-vpc
  ]
 tags = {
    Name = "Gordon-terraform-SG"
    Environment = "Testing"
    Owner = "The great gordon-DevOps"
    Created-by = "Terraform"
  }
}

resource "aws_instance" "gordon-ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.public-subnet[1].id
  vpc_security_group_ids = ["${aws_security_group.gordon-sg.id}"]
  key_name = aws_key_pair.gordon-key.key_name
  user_data = "${file("scripts/userdata.sh")}"

  tags = {
    Name = var.instance_name
    Environment = "Testing"
    Owner = "The great gordon-DevOps"
    Created-by = "Terraform"
  }
}

resource "local_file" "pem_key" {

  content = tls_private_key.gordon-key.private_key_pem
  filename = "privatekey.pem"
  
}

