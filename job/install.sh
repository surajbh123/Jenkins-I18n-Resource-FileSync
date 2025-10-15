## Install Java 21 JRE on Ubuntu if not already installed
#!/bin/bash

## check if java exists else install it
if type -p java; then
    echo "Java found in PATH"
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo "Java found in JAVA_HOME"
    _java="$JAVA_HOME/bin/java"
else
    echo "Java is not installed. Installing Java 21 JRE..."
    sudo apt update
    sudo apt install fontconfig openjdk-21-jre
    java -version
    if [ $? -ne 0 ]; then
        echo "Java installation failed. Please check your package manager settings."
        exit 1
    fi
fi

## check if Jenkins exists else install it
if ! grep -qi '^ID=ubuntu' /etc/os-release; then
    echo "Not Ubuntu - aborting."
    exit 1
else
    sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
    echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install jenkins
    # change jenkins home directory permissions
fi

