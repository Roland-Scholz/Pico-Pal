@echo off

set RELEASE=EgoTest
set SOURCE=%RELEASE%.asm
set TARGET=%RELEASE%.xex
..\bin\mads -o:%TARGET% -l -t %SOURCE%
if errorlevel 1 goto :error
rem start %TARGET% 
rem pause
goto :eof

:error
echo ERROR: See messages above.
pause.
goto :eof