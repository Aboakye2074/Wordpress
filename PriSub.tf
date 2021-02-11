resource "aws_subnet" "pvt_subnet2" {

  vpc_id            = aws_vpc.tf_vpc.id
  availability_zone = "us-west-2b"
  cidr_block        = "192.168.2.0/24"
  map_public_ip_on_launch = false
  tags= {
     Name = "pvt-subnet2"
  }
}
