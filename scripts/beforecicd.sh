#!/bin/bash

sudo su -c "apt-get install unzip"
sudo su -c "apt-get update"
sudo su -c "service codedeploy-agent start"

KEY="$(aws s3 ls s3://jenkins-code-deploy-integration --recursive --region ap-south-1 | sort | tail -n 1 | awk '{print $4}')"
sudo su -c "aws s3 cp s3://jenkins-code-deploy-integration/$KEY /home/ubuntu/fundooNotes.zip --region ap-south-1"

sudo su -c "mkdir /home/ubuntu/fundooNotes-microservices"
sudo su -c "unzip -o /home/ubuntu/fundooNotes.zip -d /home/ubuntu/fundooNotes-microservices"
sudo su -c "cd /home/ubuntu/fundooNotes-microservices/target;
	    mv springboot-helloworld-jar-code-deploy-0.0.1-SNAPSHOT.jar /home/ubuntu/hello.jar;
	    java -jar /home/ubuntu/hello.jar"

