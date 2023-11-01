#!/bin/bash
# Update packages
yum -y update

# Configure ecs.config
mkdir /etc/ecs/
echo "ECS_CLUSTER=[your_cluster_name]" >> /etc/ecs/ecs.config
sudo chmod -R 755 /etc/ecs

# Install Docker
amazon-linux-extras install docker -y

# Start Docker
systemctl enable docker
systemctl start docker

# Add the ec2-user to Docker group 
usermod -a -G docker ec2-user 

# Install ecs-init, aws-cli
yum install -y ecs-init aws-cli

# Start ECS agent
systemctl enable ecs
systemctl start ecs

# Use AmazonLinux2(Not use AmazonLinux2023)
# amzn2-ami-ecs-hvm-2.0.20230906-x86_64-ebs
# ami-0b88a6b8e63fe7c4b

# Trouble Shooting : Please check the following logs
# /var/log/ecs/ecs-agent.log
# /var/log/ecs/ecs-init.log
# ECSInstanceRole(Allow AmazonEC2ContainerServiceforEC2Role )

# userdata execution log
# cat /var/log/cloud-init-output.log