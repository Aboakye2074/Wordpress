resource "aws_instance" "wordpress" {

  ami           = "ami-0e999cbd62129e3b1"  
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub_subnet1.id
  security_groups = [aws_security_group.tf_wp_sg.id]
  key_name = "WP-KEY"
  tags = {
    Name = "wordpress"
  }
}
resource "null_resource" "wp-sql-connection" {
  depends_on = [
    aws_instance.mysql
  ]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("/home/ec2-user/Wordpress/WP-KEY.pem") 
    host     = aws_instance.wordpress.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo su <<END",
      "yum install docker httpd -y",
      "systemctl enable docker",
      "systemctl start docker",
      "docker pull wordpress:5.1.1-php7.3-apache",
      "sleep 30",
      "docker run -dit  -e WORDPRESS_DB_HOST=${aws_instance.mysql.private_ip} -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wppass -e WORDPRESS_DB_NAME=wpdb -p 80:80 wordpress:5.1.1-php7.3-apache",
      "END",
    ]
  }
  
}
