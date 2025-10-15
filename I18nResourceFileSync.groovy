import java.io.File
import java.io.FileInputStream
import java.util.Properties

println "Starting I18n Resource File Sync Job"

def workspacePath = System.getenv("WORKSPACE")
if (!workspacePath) {
    // If WORKSPACE is not set, maybe we are running locally.
    // For local testing, let's assume the workspace is the current directory.
    workspacePath = new File(".").getAbsolutePath()
    println "WORKSPACE environment variable not set. Defaulting to current directory: ${workspacePath}"
}
def propsFile = new File(workspacePath, 'git.properties')

if (propsFile.exists()) {
    def props = new Properties()
    new FileInputStream(propsFile).withCloseable { stream ->
        props.load(stream)
    }

    def githubUrl = props.getProperty('githubUrl')
    def filePath = props.getProperty('filePath')
    def branchName = props.getProperty('branchName')

    println "GitHub URL: ${githubUrl}"
    println "File Path: ${filePath}"
    println "Branch Name: ${branchName}"
} else {
    println "Properties file not found: ${propsFile.path}"
}
