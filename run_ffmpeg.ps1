# run_ffmpeg.ps1

# Folders relative to the script location
$inputFolder     = Join-Path $PSScriptRoot "input"
$outputFolder    = Join-Path $PSScriptRoot "output"
$convertedFolder = Join-Path $PSScriptRoot "converted"

# Make sure output/converted folders exist
New-Item -ItemType Directory -Force -Path $outputFolder | Out-Null
New-Item -ItemType Directory -Force -Path $convertedFolder | Out-Null

# Get the first video file
$video = Get-ChildItem "$inputFolder\*.mp4","$inputFolder\*.avi","$inputFolder\*.mkv" -File | Select-Object -First 1

if ($null -eq $video) {
    Write-Output "No video files found in $inputFolder"
    exit
}

# Output filename inside the "output" folder
$outputFile = Join-Path $outputFolder ($video.BaseName + "_out.mp4")

.\ffmpeg -i $video.FullName -c:v libx264 -b:v 1.5M -c:a aac -b:a 128k -crf 30 $outputFile

# Move the original file into "converted"
Move-Item -Path $video.FullName -Destination $convertedFolder -Force

Write-Output "Done! Output saved to $outputFile"
Write-Output "Original moved to $convertedFolder"
