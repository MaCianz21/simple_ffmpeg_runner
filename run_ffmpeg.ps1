# run_ffmpeg.ps1

# Folders relative to the script location
$inputFolder     = Join-Path $PSScriptRoot "input"
$outputFolder    = Join-Path $PSScriptRoot "output"
$convertedFolder = Join-Path $PSScriptRoot "converted"

# Make sure output/converted folders exist
New-Item -ItemType Directory -Force -Path $outputFolder | Out-Null
New-Item -ItemType Directory -Force -Path $convertedFolder | Out-Null

# Get all video files
$videos = Get-ChildItem "$inputFolder\*.mp4","$inputFolder\*.avi","$inputFolder\*.mkv" -File

if ($videos.Count -eq 0) {
    Write-Output "No video files found in $inputFolder"
    exit
}

Write-Output "Found $($videos.Count) video file(s) to process"

# Process each video file
foreach ($video in $videos) {
    Write-Output "Processing: $($video.Name)"
    
    # Output filename inside the "output" folder
    $outputFile = Join-Path $outputFolder ($video.BaseName + "_out.mp4")
    
    .\ffmpeg -i $video.FullName -c:v libx264 -b:v 1.5M -c:a aac -b:a 128k -crf 30 $outputFile
    
    if ($LASTEXITCODE -eq 0) {
        # Move the original file into "converted" only if ffmpeg succeeded
        Move-Item -Path $video.FullName -Destination $convertedFolder -Force
        Write-Output "✓ Completed: $($video.Name) -> $($video.BaseName)_out.mp4"
    } else {
        Write-Output "✗ Failed to process: $($video.Name)"
    }
}

Write-Output "All videos processed!"
