resource "aws_instance" "mysql" {
  depends_on = [
    aws_instance.wordpress
  ]
  ami           = "ami-0e999cbd62129e3b1"  
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pvt_subnet2.id
  security_groups = [aws_security_group.tf_sql_sg.id]
  # key_name = "WP-KEY"
  user_data = <<END
  #!/bin/bash
  sudo yum install mariadb-server mysql -y
  sudo systemctl enable mariadb.service
  sudo systemctl start mariadb.service
  mysql -u root <<EOF
  create user 'wpuser'@'${aws_instance.wordpress.private_ip}' identified by 'wppass';
  create database wpdb;
  grant all privileges on wpdb.* to 'wpuser'@'${aws_instance.wordpress.private_ip}';
  exit
  EOF
  END
 
  tags = {
    Name = "sql"
  }
}
