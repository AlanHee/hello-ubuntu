#!/bin/bash
PID=$1
ps auxww | grep PID
#or
#ps -ef
#or
#lsof -p PID
#or
#top -p PID
