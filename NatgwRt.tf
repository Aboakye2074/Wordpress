# EIP
resource "aws_eip" "tf-eip" {
  tags = {
    "Name" = "vpc-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "tf_ngw" {

  allocation_id = aws_eip.tf-eip.id
  subnet_id     = aws_subnet.pub_subnet1.id
  tags = {
    "Name" = "tf-ng"
  }
}

# NGW Route Table
resource "aws_default_route_table" "tf_ng_route" {
  depends_on = [
    aws_nat_gateway.tf_ngw
  ]
  default_route_table_id = aws_vpc.tf_vpc.default_route_table_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tf_ngw.id
  }
  tags = {
    Name = "tf-ng-route"
  }
}

# NGW route association
resource "aws_route_table_association" "tf_ng_assoc" {

  subnet_id      = aws_subnet.pvt_subnet2.id
  route_table_id = aws_default_route_table.tf_ng_route.id
}

