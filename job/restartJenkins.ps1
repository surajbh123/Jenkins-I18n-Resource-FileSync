# Stop Jenkins
net stop jenkins
Start-Sleep -Seconds 5

$jobName = "I18n-Resource-FileSync"
$jenkinsHome = "C:\ProgramData\Jenkins\.jenkins"
$workspaceFolder = Join-Path $jenkinsHome "workspace\$jobName"

$jobDir = Join-Path $jenkinsHome "jobs\$jobName"


# Ensure the workspace folder exists. If not, create it.
if (!(Test-Path -Path $workspaceFolder)) {
    Write-Host "Workspace directory not found. Creating it at: $workspaceFolder"
    New-Item -ItemType Directory -Path $workspaceFolder -Force
}

# Copy the properties file to the Jenkins workspace, overwriting if it exists.
Write-Host "Copying git.properties to $workspaceFolder"
Copy-Item -Path "$PSScriptRoot\git.properties" -Destination $workspaceFolder -Force

# Start Jenkins
net start jenkins

# Notify user
Write-Host "Jenkins has been restarted and files are updated."
# end of script
