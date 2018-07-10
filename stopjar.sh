#!/bin/bash
# Grabs and kill a process from the pidlist that has the word hello.jar

pid=`ps aux | grep hello.jar | awk '{print $2}'`
kill -9 $pid
exit
