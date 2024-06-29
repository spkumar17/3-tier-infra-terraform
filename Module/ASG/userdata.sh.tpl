#!/bin/bash

# Update packages and install necessary tools
sudo apt update
sudo apt install docker.io docker-compose git screen -y

# Download the latest version of Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Enable and start the Docker service
sudo systemctl enable docker.service --now

# Add users to the Docker group (replace ssm-user and ec2-user with your Ubuntu user)
sudo usermod -aG docker $USER

# Pull the latest Ubuntu image from Docker Hub (adjust image name as needed)
sudo docker pull prasannakumarsinganamalla431/petclinic:25

# Run Docker container with environment variables
sudo docker run -d --name petclinic -e MYSQL_URL=jdbc:mysql://${db_instance_endpoint}:3306/petclinic -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=petclinic -p 80:80 prasannakumarsinganamalla431/petclinic:25