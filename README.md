# Simple FFmpeg Runner

A PowerShell script for batch video processing using FFmpeg.

## Overview

This script automatically processes all video files in an input folder, converts them using FFmpeg with predefined settings, and organizes the results into separate folders.

## Folder Structure

```
simple_ffmpeg_runner/
├── run_ffmpeg.ps1          # Main script
├── input/                  # Place video files here
├── output/                 # Converted videos appear here
└── converted/              # Original files moved here after processing
```

## Supported Formats

- MP4 (.mp4)
- AVI (.avi)
- MKV (.mkv)

## Usage

1. Place your video files in the `input/` folder
2. Run the PowerShell script:
   ```powershell
   .\run_ffmpeg.ps1
   ```

## Video Settings

The script converts videos with these settings:
- Video codec: H.264 (libx264)
- Video bitrate: 1.5 Mbps
- Audio codec: AAC
- Audio bitrate: 128 kbps
- CRF: 30 (quality setting)

## Requirements

- FFmpeg executable in the same directory as the script
- PowerShell
- Write permissions for creating output folders

## What It Does

1. Creates `output/` and `converted/` folders if they don't exist
2. Finds all video files in the `input/` folder
3. Processes each video file with FFmpeg
4. Saves converted files to `output/` with "_out" suffix
5. Moves original files to `converted/` folder (only if conversion succeeds)
6. Provides progress updates and completion status for each file