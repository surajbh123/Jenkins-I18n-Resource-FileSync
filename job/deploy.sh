#!/bin/bash


## Stop the Jenkins service if running
echo "Stopping Jenkins service..."
sudo service jenkins stop || true

# wait for a few seconds to ensure it stops
echo "Waiting for Jenkins to stop..."
sleep 5

JENKINS_HOME="/var/lib/jenkins"

## Job information
JOB_NAME="I18n-Resource-FileSync"
JOB_DIR="$JENKINS_HOME/jobs/$JOB_NAME"
WORKSPACE_DIR="$JENKINS_HOME/workspace/$JOB_NAME"

echo "Job Directory: $JOB_DIR"
echo "Workspace Directory: $WORKSPACE_DIR"

## WARNING: Deleting job directory will destroy the job configuration!
## Only delete workspace, not the job directory itself.
## Uncomment the following block if you really want to delete the job:
# if [ -d "$JOB_DIR" ]; then
#     echo "Removing job directory: $JOB_DIR"
#     sudo rm -rf "$JOB_DIR"
# fi

## delete workspace directory if exists for a clean start
if [ -d "$WORKSPACE_DIR" ]; then
    echo "Cleaning workspace directory: $WORKSPACE_DIR"
    sudo rm -rf "$WORKSPACE_DIR"
fi


echo "Cleaned up workspace directory."

## create job and workspace directory and give permission READ/WRITE
sudo mkdir -p "$JOB_DIR"
sudo chown -R jenkins:jenkins "$JOB_DIR"
sudo chmod -R 755 "$JOB_DIR"

sudo mkdir -p "$WORKSPACE_DIR"
sudo chown -R jenkins:jenkins "$WORKSPACE_DIR"
sudo chmod -R 755 "$WORKSPACE_DIR"


echo "Copying configuration files to workspace..."
    sudo cp ./config/*.properties "$WORKSPACE_DIR/"
    sudo chown jenkins:jenkins "$WORKSPACE_DIR/"*.properties
    sudo chmod 644 "$WORKSPACE_DIR/"*.properties
    echo "Configuration files copied successfully."


## give permission to jenkins home directory read/write (final permissions)
sudo chown -R jenkins:jenkins "$JENKINS_HOME"
sudo chmod -R 755 "$JENKINS_HOME"

## Start the Jenkins service
echo "Starting Jenkins service..."
sudo service jenkins start

echo "Deployment complete. Jenkins is starting up..."