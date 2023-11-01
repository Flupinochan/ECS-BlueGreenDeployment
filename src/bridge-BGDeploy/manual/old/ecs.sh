#!/bin/bash
# Update packages
yum -y update

# Install Docker
yum install -y docker

# Start Docker
systemctl start docker

# Add the ec2-user to Docker group 
usermod -a -G docker ec2-user 

# Install ecs-init, aws-cli
yum install -y ecs-init aws-cli

# Configure ecs.config
echo "ECS_CLUSTER=[your_cluster_name]" >> /etc/ecs/ecs.config

# Restart the ECS agent
systemctl restart ecs

# Trouble Shooting : Please check the following logs
# /var/log/ecs/ecs-agent.log
# /var/log/ecs/ecs-init.log
# ECSInstanceRole(Allow AmazonEC2ContainerServiceforEC2Role )

# userdata execution log
# cat /var/log/cloud-init-output.log