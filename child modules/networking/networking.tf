resource "aws_vpc" "myvpc1" {
  cidr_block = var.vpc_cidr

  tags = var.vpc_tags
}

resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc1.id

  tags = var.igw_tags
  }

  resource "aws_route_table" "mypubrt" {
  vpc_id = aws_vpc.myvpc1.id

  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = var.pubrt_tags
}

resource "aws_subnet" "pubsub1" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.pubsub1_cidr
  map_public_ip_on_launch = true

  tags = var.pubsub1_tags
}

resource "aws_subnet" "pubsub2" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.pubsub2_cidr
  map_public_ip_on_launch = true

  tags = var.pubsub2_tags
}

resource "aws_subnet" "pubsub3" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.pubsub3_cidr
  map_public_ip_on_launch = true

  tags = var.pubsub3_tags
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.mypubrt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.mypubrt.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.pubsub3.id
  route_table_id = aws_route_table.mypubrt.id
}

resource "aws_subnet" "privsub1" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.privsub1_cidr

  tags = var.privsub1_tags
}

resource "aws_subnet" "privsub2" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.privsub2_cidr

  tags = var.privsub2_tags
}

resource "aws_subnet" "privsub3" {
  vpc_id     = aws_vpc.myvpc1.id
  cidr_block = var.privsub3_cidr

  tags = var.privsub3_tags
}

output "vpc_id" {
  value = aws_vpc.myvpc1.id
}

# route table for private subnets

resource "aws_route_table" "myprivrt" {
  vpc_id = aws_vpc.myvpc1.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "priv1" {
  route_table_id = aws_route_table.myprivrt.id
  subnet_id = aws_subnet.privsub1.id
}

resource "aws_route_table_association" "privs" {
  route_table_id = aws_route_table.myprivrt.id
  subnet_id = aws_subnet.privsub2.id
}

resource "aws_route_table_association" "priv3" {
  route_table_id = aws_route_table.myprivrt.id
  subnet_id = aws_subnet.privsub3.id
}