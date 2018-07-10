#!/bin/bash

pwd
sudo su -c "whoami"
sudo su -c "apt-get install unzip"
sudo su -c "apt-get update"
sudo su -c "service codedeploy-agent start"
