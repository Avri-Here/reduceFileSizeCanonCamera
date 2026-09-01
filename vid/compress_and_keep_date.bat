@echo off
setlocal

set "outputDir=.\outpot_videos"

if not exist "%outputDir%" mkdir "%outputDir%"

for %%f in (".\canon_videos*.MP4") do (
echo Converting file: "%%f"

```
ffmpeg -loglevel panic -y -i "%%f" -vcodec libx264 -crf 23 -preset medium -acodec aac -b:a 192k "%outputDir%\%%~nf.mp4"

if errorlevel 1 (
    echo ERROR: Conversion failed for "%%f"
) else (
    exiftool -tagsFromFile "%%f" -all:all "%outputDir%\%%~nf.mp4"

    del "%outputDir%\%%~nf.mp4_original"

    echo Conversion successful. Deleting original: "%%f"
    del "%%f"
)
```

)

echo Script complete!
pause
