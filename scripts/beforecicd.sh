#!/bin/bash

### INSTALLING ALL THE DEPENDENCIES REQUIRED ###
sudo su -c "apt-get install unzip"
sudo su -c "apt-get update && apt-get install python-pip"
sudo su -c "pip install awscli"
sudo su -c "apt-get update"

### STARTING THE CODE-DEPLOY SERVICE IF IT IS STOPPED ###
sudo su -c "service codedeploy-agent start"

### STOPPING THE PREVIOUS PROCESS OF JAR FILE AND REMOVING/DELETING ALL THE FILES STORED ###
sudo su -c "sudo kill -9 `ps aux | grep hello.jar | awk '{print $2}'`"
sudo su -c "rm -rf /home/ubuntu/fundooNotes-microservices;
	    rm -rf /home/ubuntu/hello.jar"

### PULLING THE LATEST ZIP-FILE FROM THE S3 BUCKET AND UNZIPPING IT IN THE REQUIRED FOLDER###
KEY="$(aws s3 ls s3://jenkins-code-deploy-integration --recursive --region ap-south-1 | sort | tail -n 1 | awk '{print $4}')"
sudo su -c "aws s3 cp s3://jenkins-code-deploy-integration/$KEY /home/ubuntu/$KEY --region ap-south-1"
sudo su -c "mkdir /home/ubuntu/fundooNotes-microservices"
sudo su -c "unzip -o /home/ubuntu/$KEY -d /home/ubuntu/fundooNotes-microservices"

### DELETING THE ZIP FILE AND RUNNING THE NEW UNZIPPED JAR FILE AS A BACKGROUND PROCESS ###
sudo su -c "rm -rf /home/ubuntu/$KEY"
sudo su -c "cd /home/ubuntu/fundooNotes-microservices/target;
	    mv springboot-helloworld-jar-code-deploy-0.0.1-SNAPSHOT.jar /home/ubuntu/hello.jar;
	    nohup java -jar /home/ubuntu/hello.jar > /home/ubuntu/log.txt 2>&1 &"

