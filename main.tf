provider "aws" {
  region = "eu-west-2"
}

# 1. Security Group for Web & Internal Traffic
resource "aws_security_group" "shriram_ecommerce_sg" {
  name = "shriram_ecommerce-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Public Frontend
  }

  ingress {
    from_port   = 3001
    to_port     = 3004
    protocol    = "tcp"
    self        = true # Internal Microservices
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. EC2 Instance with Automated Docker Setup
resource "aws_instance" "ecommerce_host" {
  ami           = "ami-09dbc7ce74870d573" # Ubuntu 22.04 LTS
  instance_type = "t3.medium"            # Use medium to handle 5 containers
  vpc_security_group_ids = [aws_security_group.shriram_ecommerce_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io
              systemctl start docker
              
              # Pull and run the 4 Backend services
              docker run -d --name user-svc -p 3001:3001 shriramparab4/e-commerce-user
              docker run -d --name prod-svc -p 3002:3002 shriramparab4/e-commerce-product
              docker run -d --name ord-svc -p 3003:3003 shriramparab4/e-commerce-order
              docker run -d --name cart-svc -p 3004:3004 shriramparab4/e-commerce-cart
              
              # Run Frontend on Port 80
              docker run -d --name frontend -p 80:3000 dock
              EOF

  tags = { Name = "DevOps-Assignment-Server" }
}

output "public_ip" {
  value = aws_instance.ecommerce_host.public_ip
}