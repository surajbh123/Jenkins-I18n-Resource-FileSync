## It is a bash script on Ubuntu WSL

## Run Jenkins job to deploy the changes locally
#!/bin/bash

## Stop the Jenkins service if running
sudo service jenkins stop
# wait for a few seconds to ensure it stops
sleep 5
## give permission to jenkins home directory read/write
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chmod -R 755 /var/lib/jenkins
## Job information
JOB_NAME="I18n-Resource-FileSync"
JENKINS_HOME="/var/lib/jenkins"
JOB_DIR="$JENKINS_HOME/jobs/$JOB_NAME"
WORKSPACE_DIR="$JENKINS_HOME/workspace/$JOB_NAME"

## Create the job directory if it doesn't exist
if [ ! -d "$JOB_DIR" ]; then
    sudo mkdir -p "$JOB_DIR"
    sudo chown -R jenkins:jenkins "$JOB_DIR"
    sudo chmod -R 755 "$JOB_DIR"
fi
## Create the workspace directory if it doesn't exist
if [ ! -d "$WORKSPACE_DIR" ]; then
    sudo mkdir -p "$WORKSPACE_DIR"
    sudo chown -R jenkins:jenkins "$WORKSPACE_DIR"
    sudo chmod -R 755 "$WORKSPACE_DIR"
fi

## Copy properties file to the Jenkins home
cp ./git.properties "$WORKSPACE_DIR/git.properties"

## Start the Jenkins service
sudo service jenkins start