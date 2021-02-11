resource "aws_security_group" "tf_sql_sg" {
  depends_on = [
    aws_route_table_association.tf_ng_assoc
  ]

  name        = "tf_sql_sg"
  description = "mysql inbound"
  vpc_id      = aws_vpc.tf_vpc.id
  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.tf_wp_sg.id]

  }

  # ingress {
  #   description = "ping"
  #   from_port   = -1
  #   to_port     = -1
  #   protocol    = "icmp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   description = "ssh"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf_sql_sg"
  }
}

