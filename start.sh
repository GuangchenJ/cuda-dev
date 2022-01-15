#!/bin/sh

# Set the new password
echo "Enter the new password of the user root in the container"
read new_pwd
export pwd=$new_pwd

# build Docker Image
# docker-compose build

docker-compose up -d
