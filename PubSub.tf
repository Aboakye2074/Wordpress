resource "aws_subnet" "pub_subnet1" {

  vpc_id            = aws_vpc.tf_vpc.id
  availability_zone = "us-west-2a"
  cidr_block        = "192.168.1.0/24"
  map_public_ip_on_launch = true
  tags= {
     Name = "pub-subnet1"
  }
}
