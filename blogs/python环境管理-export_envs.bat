@echo off
set BASE=E:\Anaconda3-2019.10-Windows-x86_64\envs
set OUT=%cd%\requirements_exports

if not exist "%OUT%" (
    mkdir "%OUT%"
)

echo Exporting pip requirements...
echo.

for %%E in (
    ISAT_with_segment_anything
    langchain
    mxnet
    py36_NLP
    py36_torch
    py37
    py38
    py310
    tensorflow1.5
    tensorflow1.12
    tensorflow-gpu
    tensorflow-gpu2
    tensorflow-yolov3
    yolov8
) do (
    echo === %%E ===
    "%BASE%\%%E\python.exe" -m pip freeze > "%OUT%\%%E_requirements.txt"
)

echo.
echo Done!
pause
