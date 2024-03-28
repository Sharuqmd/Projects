terraform {
  required_version = ">= 0.12"
  required_providers {
     aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
}
provider "aws" {
  region = "ap-south-1b"
}
resource "aws_instance" "jenkins_master" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"                
  key_name      = "your-key-pair"           
  tags = {
    Name = "jenkins-master"
  }
}

resource "aws_instance" "jenkins_slave" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"                
  key_name      = "your-key-pair"           
  tags = {
    Name = "jenkins-slave"
  }
}


#!/bin/bash

# Add the Jenkins repository key to apt
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

# Add the Jenkins repository to the system's package sources
echo "deb https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list

# Update your package list to include the Jenkins repository
sudo apt update

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Display initial admin password
echo "Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
