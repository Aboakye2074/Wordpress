# Internet Gateway
resource "aws_internet_gateway" "tf_ig" {

  vpc_id = aws_vpc.tf_vpc.id
  tags = {
    Name = "tf-ig"
  }
}

# IGW Route Table
 resource "aws_route_table" "tf_ig_route" {

  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_ig.id
  }
  tags = {
    Name = "tf-ig-route"
  }
}

# IGW Route Association
resource "aws_route_table_association" "tf_ig_assoc" {

  subnet_id      = aws_subnet.pub_subnet1.id
  route_table_id = aws_route_table.tf_ig_route.id
}

