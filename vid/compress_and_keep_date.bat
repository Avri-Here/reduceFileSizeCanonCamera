@echo off
setlocal

cd /d "%~dp0"

set "outputDir=.\outpot_videos"

if not exist "%outputDir%" mkdir "%outputDir%"

echo Current directory:
cd

echo.
echo Searching for videos...
echo.

for %%f in (".\canon_videos_now\*.MP4") do (
    echo ========================================
    echo Converting file: "%%f"

    ffmpeg -loglevel error -y -i "%%f" -vcodec libx264 -crf 23 -preset medium -acodec aac -b:a 192k "%outputDir%\%%~nf.mp4"

    if errorlevel 1 (
        echo ERROR: Conversion failed for "%%f"
    ) else (
        exiftool -tagsFromFile "%%f" -all:all -overwrite_original "%outputDir%\%%~nf.mp4"

        if errorlevel 1 (
            echo ERROR: Failed to copy metadata.
            echo Original was NOT deleted.
        ) else (
            echo Conversion successful.
            echo Deleting original: "%%f"

            del /f /q "%%f"

            if exist "%%f" (
                echo ERROR: Could not delete original!
            ) else (
                echo Original deleted successfully.
            )
        )
    )
)

echo.
echo Script complete!
pause