resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
 }

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

#   provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
#     command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
#   }
# }   


resource "aws_instance" "bookstack_instance" {
  ami           = "ami-08a0d1e16fc3f61ea"  # Specify your desired AMI
  instance_type = "t2.micro"          # Adjust instance type as needed
  key_name      = "mykey" # Specify your SSH key pair name
  security_groups = ["${aws_security_group.bookstack_sg.name}"]  # Ensure this security group allows inbound on port 8080

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo reboot
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    mkdir -p ~/bookstack
    echo '${file("docker-compose.yml")}' > ~/bookstack/docker-compose.yml
    cd ~/bookstack && sudo docker-compose up -d
  EOF
}

resource "aws_eip" "bookstack_eip" {
  instance = aws_instance.bookstack_instance.id
}

resource "aws_security_group" "bookstack_sg" {
  name        = "bookstack-sg"
  description = "Security group for Bookstack application"

  // Inbound rules
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound rules (by default, all traffic is allowed)
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
