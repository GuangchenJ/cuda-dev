#!/bin/sh

# Set the new password
export pwd=new_password

# build Docker Image
docker-compose build

docker-compose up -d

