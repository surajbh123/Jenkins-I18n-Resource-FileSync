# Stop Jenkins
net stop jenkins
# Wait for a few seconds to ensure Jenkins has stopped
Start-Sleep -Seconds 5
# copy new config.xml from this location to Jenkins home
# Ensure the destination folder exists
$destinationFolder = "C:\ProgramData\Jenkins\.jenkins\jobs\I18n-Resource-FileSync"

# delete destination folder if it exists to avoid conflicts
if (Test-Path -Path $destinationFolder) {
    Remove-Item -Path $destinationFolder -Recurse -Force
}

if (!(Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
}

# Copy the config.xml file
Copy-Item -Path "$PSScriptRoot\config.xml" -Destination "$destinationFolder\config.xml" -Force

# Copy the properties file and Groovy script to Jenkins workspace
$workspaceFolder = "C:\ProgramData\Jenkins\.jenkins\workspace\I18n-Resource-FileSync"
if (!(Test-Path -Path $workspaceFolder)) {
    New-Item -ItemType Directory -Path $workspaceFolder -Force
}
Copy-Item -Path "$PSScriptRoot\git.properties" -Destination "$workspaceFolder\git.properties" -Force
Copy-Item -Path "$PSScriptRoot\I18nResourceFileSync.groovy" -Destination "$workspaceFolder\I18nResourceFileSync.groovy" -Force

net start jenkins
# Notify user
echo Jenkins has been restarted.
# end of script
