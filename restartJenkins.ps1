# Stop Jenkins
net stop jenkins
# Wait for a few seconds to ensure Jenkins has stopped
Start-Sleep -Seconds 5
# copy new config.xml from this location to Jenkins home
# Ensure the destination folder exists
$destinationFolder = "C:\ProgramData\Jenkins\.jenkins\jobs\I18n-Resource-FileSync"
if (!(Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder -Force
}

# Copy the config.xml file
Copy-Item -Path "$PSScriptRoot\config.xml" -Destination "$destinationFolder\config.xml" -Force
net start jenkins
# Notify user
echo Jenkins has been restarted.
# end of script
