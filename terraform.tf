resource "aws_vpc" "projvpc" {
  cidr_block = "190.0.0.0/16"
  enable_dns_support= true
  enable_dns_hostnames= true
  tags = {
    Name= "drenet"
  }
}
resource "aws_subnet" "projsnpub" {
  cidr_block = "190.0.0.0/24"
  vpc_id = aws_vpc.projvpc.id
  map_public_ip_on_launch= true
  tags = {
    Name= "drenetsnpub"
  }
}
resource "aws_subnet" "projsnprvt" {
  cidr_block = "190.0.1.0/24"
  vpc_id = aws_vpc.projvpc.id
  map_public_ip_on_launch= true
  tags = {
    Name= "drenetsnprv"
  }
}
resource "aws_subnet" "projsnpub1" {
  cidr_block = "190.0.2.0/24"
  vpc_id = aws_vpc.projvpc.id
  map_public_ip_on_launch= true
  tags = {
    Name= "drenetsnpub1"
  }
}
resource "aws_subnet" "projsnprvt1" {
  cidr_block = "190.0.3.0/24"
  vpc_id = aws_vpc.projvpc.id
  map_public_ip_on_launch= true
  tags = {
    Name= "drenetsnprvt1"
  }
}
resource "aws_internet_gateway" "projgw" {
  vpc_id = aws_vpc.projvpc.id
  tags = {
    Name= "drenetgw"
  }
}
resource "aws_route_table" "projpubrt" {
  vpc_id = aws_vpc.projvpc.id
  tags = {
    Name= "drenetrt"
  }
}
resource "aws_route_table_association" "projrtass" {
  route_table_id = aws_route_table.projpubrt.id
  subnet_id = aws_subnet.projsnpub.id
}
resource "aws_route_table_association" "projrtass1" {
  route_table_id = aws_route_table.projpubrt.id
  subnet_id = aws_subnet.projsnpub1.id
}

resource "aws_route" "projroute" {
  route_table_id = aws_route_table.projpubrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.projgw.id
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
  
}