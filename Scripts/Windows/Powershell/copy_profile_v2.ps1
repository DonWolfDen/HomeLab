# Create log file and logging function
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logErrors = "C:\TechFile\CopyErrors_$timestamp.log"
$logSkipped = "C:\TechFile\SkippedFiles_$timestamp.log"
if (!(Test-Path -Path $logErrors)) {
	New-Item -Path $logErrors -ItemType File -Force
}
if (!(Test-Path -Path $logSkipped)) {
    New-Item -Path $logSkipped -ItemType File -Force
}
function Write-Log {
	param(
		[string]$Message,
		[string]$SkippedFile
	)
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	$logEntry = "[$timestamp] $Message`n"
	Add-Content -Path $logErrors -Value $logEntry
	$skippedLogEntry = "[$timestamp] Skipped: $SkippedFile`n"
	Add-Content -Path $logSkipped -Value $skippedLogEntry
}

# Prompt the user for input
$sourceUser = Read-Host "Enter the source user name exactly as written in C:\Users"
$destinationUser = Read-Host "Enter the destination user name exactly as written in C:\Users"
$folder = Read-Host "Enter the folder to copy (Only one folder. example: Documents)"

# Construct the source and destination paths
$sourceRoot = "C:\Users\$sourceUser\$folder"
$destinationRoot = "C:\Users\$destinationUser\$folder"

# Loop through each source file recursively
Get-ChildItem -Path $sourceRoot -Recurse -File | ForEach-Object {
	try {
		# Construct the full destination path from the current Object
		$sourcePath = $_.FullName
		$relativePath = $sourcePath.Substring($sourceRoot.Length)
		$destinationPath = Join-Path -Path $destinationRoot -ChildPath $relativePath

		# Create the destination path if it doesn't exist
		$destinationDir = Split-Path -Path $destinationPath -Parent
		if (-not (Test-Path $destinationDir)) {
			New-Item -Path $destinationDir -ItemType Directory -Force | Out-Null
		}

		# Copy the item
		Copy-Item -Path $sourcePath -Destination $destinationPath -Force -Verbose
	}
	catch {
		$errorMessage = "Failed to copy: $sourcePath. Error: $($_.Exception)"
		Write-Warning $errorMessage
		Write-Log -Message $errorMessage -SkippedFile $sourcePath
	}
}

Write-Information "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Copy complete. Errors and skipped files can be found in C:\TechFile"
