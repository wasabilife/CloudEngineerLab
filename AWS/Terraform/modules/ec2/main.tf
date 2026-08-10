resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = "cloud-lab-key"

  user_data = <<-EOF
#!/bin/bash

dnf update -y

dnf install -y httpd

systemctl enable httpd

systemctl start httpd

echo "<h1>Cloud Engineer Lab</h1>" > /var/www/html/index.html

EOF

  tags = {
    Name = "terraform-web-server"
  }
}