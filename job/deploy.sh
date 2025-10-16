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

echo "Created job and workspace directories with appropriate permissions."

## Copy properties file to the workspace
if [ -f "./git.properties" ]; then
    echo "Copying git.properties to workspace..."
    sudo cp ./git.properties "$WORKSPACE_DIR/git.properties"
    sudo chown jenkins:jenkins "$WORKSPACE_DIR/git.properties"
    sudo chmod 644 "$WORKSPACE_DIR/git.properties"
    echo "git.properties copied successfully."
else
    echo "ERROR: git.properties not found in current directory!"
    exit 1
fi

## give permission to jenkins home directory read/write (final permissions)
sudo chown -R jenkins:jenkins "$JENKINS_HOME"
sudo chmod -R 755 "$JENKINS_HOME"

## Start the Jenkins service
echo "Starting Jenkins service..."
sudo service jenkins start

echo "Deployment complete. Jenkins is starting up..."