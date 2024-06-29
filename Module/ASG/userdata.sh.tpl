#!/bin/bash

# Update the system packages
sudo apt-get update -y


# Start the Docker service
sudo systemctl start docker

# Add the 'ec2-user' to the 'docker' group (for managing Docker without sudo)
sudo usermod -a -G docker ec2-user

# Add the 'ssm-user' to the 'docker' group (for managing Docker without sudo)
sudo usermod -a -G docker ssm-user

# Restart Docker service to apply group changes
sudo systemctl restart docker

# Check Docker version (optional, corrected command)
sudo docker version

# Run Docker container with environment variables
sudo docker run -d --name petclinic -e MYSQL_URL=jdbc:mysql://${MYSQL_URL}:3306/petclinic -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=petclinic -p 8888:8888 prasannakumarsinganamalla431/petclinic:23
