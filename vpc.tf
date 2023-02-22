resource "aws_vpc" "Gordon-vpc" {
  cidr_block     = var.vpc_cidr
  instance_tenancy = "default"


  tags = {
    Name = "terraform-vpc"
    created-by = "Gordon"
    Environment = "Practice"
  }
}

resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.Gordon-vpc.id
  map_public_ip_on_launch = true
  cidr_block = element(var.public_subnet_cidrs, count.index)
  tags = {
    "Name" = "terraform-public-${count.index}"
    Environment = "Practice"
    Created-by = "Gordon"
  }
}

resource "aws_subnet" "private-subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.Gordon-vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  tags = {
    "Name" = "terraform-private-${count.index}"
    Environment = "Practice"
    Created-by = "Gordon"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.Gordon-vpc.id
  tags = {
    Name = "Terraform-igw"
    Created-by = "Gordon"
    Environment = "Practice"
  }
}

resource "aws_route_table" "terraform-rt" {
  vpc_id = aws_vpc.Gordon-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
    Name = "Terraform-rt"
    Created-by = "Gordon"
    Environment = "Practice"
  }
}

resource "aws_route_table_association" "public1-association" {
  subnet_id      = aws_subnet.public-subnet[0].id
  route_table_id = aws_route_table.terraform-rt.id
}
resource "aws_route_table_association" "public2-association" {
  subnet_id      = aws_subnet.public-subnet[1].id
  route_table_id = aws_route_table.terraform-rt.id
}