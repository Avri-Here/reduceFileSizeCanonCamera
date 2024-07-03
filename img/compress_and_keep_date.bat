@echo off
setlocal

set "outputDir=.\outpot_photos"

if not exist "%outputDir%" mkdir "%outputDir%"

for %%f in (".\canon_photos\*.JPG") do (
    echo Converting file: "%%f"
    ffmpeg -loglevel panic -y -i "%%f" -q:v 2 "%outputDir%\%%~nf.jpg"
    exiftool -tagsFromFile "%%f" -all:all -orientation#=1 "%outputDir%\%%~nf.jpg"
    del "%outputDir%\%%~nf.jpg_original"
)

echo Script complete!
pause