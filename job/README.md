## TO see jenkins password
sudo -s
cat passwd.txt

## Plugins to install
1. Pipeline
2. Git
3. Config pr

## RUN install.sh and deploy.sh script use `sudo -s` if needed

## create Job
1. New Item
2. Pipeline
3. Name: I18n-Resource-FileSync
4. copy and paste Jenkinsfile content
5. Save

## for every changes in properties file run deploy.sh