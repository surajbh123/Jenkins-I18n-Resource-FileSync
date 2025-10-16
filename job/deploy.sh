## It is a bash script on Ubuntu WSL

## Run Jenkins job to deploy the changes locally
#!/bin/bash

## Stop the Jenkins service if running
sudo service jenkins stop
# wait for a few seconds to ensure it stops
echo "Waiting for Jenkins to stop..."
sleep 5
## give permission to jenkins home directory read/write
sudo chown -R jenkins:jenkins /var/lib/jenkins
sudo chmod -R 755 /var/lib/jenkins
## Job information
JOB_NAME="I18n-Resource-FileSync"
JENKINS_HOME="/var/lib/jenkins"
JOB_DIR="$JENKINS_HOME/jobs/$JOB_NAME"
WORKSPACE_DIR="$JENKINS_HOME/workspace/$JOB_NAME"

echo "Job Directory: $JOB_DIR"
echo "Workspace Directory: $WORKSPACE_DIR"

## delete job directory if exists
if [ -d "$JOB_DIR" ]; then
    sudo rm -rf "$JOB_DIR"
fi
## delete workspace directory if exists
if [ -d "$WORKSPACE_DIR" ]; then
    sudo rm -rf "$WORKSPACE_DIR"
fi

echo "Cleaned up existing job and workspace directories."

## create job and workspace directory and give permission READ/WRITE
sudo mkdir -p "$JOB_DIR"
sudo chown -R jenkins:jenkins "$JOB_DIR"
sudo chmod -R 755 "$JOB_DIR"

sudo mkdir -p "$WORKSPACE_DIR"
sudo chown -R jenkins:jenkins "$WORKSPACE_DIR"
sudo chmod -R 755 "$WORKSPACE_DIR"

echo "Created job and workspace directories with appropriate permissions."

## Copy properties file to the Jenkins home
cp ./git.properties "$WORKSPACE_DIR/git.properties"



## Start the Jenkins service
sudo service jenkins start