!/bin/bash
# Install the SSM agent (Amazon Linux 2 example)
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Update packages and install necessary tools
sudo apt update -y
sudo apt upgrade -y
sudo apt install docker.io containerd git screen -y
sleep 5
# Enable and start the Docker service
sudo systemctl enable docker.service --now
sleep 5

# Add users to the Docker group
sudo usermod -aG docker $USER
sudo usermod -aG docker ubuntu
sleep 5

# Restart the Docker service to apply group changes
sudo systemctl restart docker.service
sleep 5

# Pull the latest Ubuntu image from Docker Hub
sudo docker pull prasannakumarsinganamalla431/petclinic:23
sleep 5

export MYSQL_URL="${MYSQL_URL}"

# Run an Ubuntu container with MySQL environment variables
#sudo docker run -d --name petclinic -e MYSQL_URL=jdbc:mysql://${MYSQL_URL}/petclinic -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=petclinic -p 8888:8888 prasannakumarsinganamalla431/petclinic:23

sleep 5

echo "Docker setup and container deployment complete."
