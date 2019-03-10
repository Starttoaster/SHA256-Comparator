@echo off
cls

:start
cls
ECHO ..............................................
ECHO .             --Main Options--               .
ECHO .                                            .
ECHO . 1---See SHA256                             .
ECHO . 2---Compare path to known checksum         .
ECHO . 3---Compare two files                      .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO .                                            .
ECHO ..............................................

::|||||||||||||||||||||||||||||BACKEND SET CHOICE|||||||||||||||||||||||||||||||||||||||||

:choices
set choice=
set /p choice=Enter choice:
if '%choice%'=='1' goto sha
if '%choice%'=='2' goto compare
if '%choice%'=='3' goto compareFiles

ECHO "%choice%" is not valid please try again.



::|||||||||||||||||||||||||||Compare|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

:compare
cls
::User input for file path, and then getting a sha256 checksum and saving it to variable "compare"
setlocal enabledelayedexpansion
echo Input file path to be checked. No Quotations around file path.
set /p thisPath=
set /a count=1 
for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%thisPath%" sha256') do (
  if !count! equ 1 set "compare=%%a"
  set/a count+=1
)
set "compare=%compare: =%
cls

::User input for a checksum to be compared up against. Using Powershell to make string lowercase.
echo Input SHA256 checksum for comparison.
set /p original=
for /f "usebackq delims=" %%I in (`powershell "\"%original%\".toLower()"`) do set "lower=%%~I"
cls

::Displaying both checksums and comparing them. USE LOWER CASE ONLY.
echo Path to file selected: %thisPath%
echo File SHA256 checksum is: %compare%
echo Original file checksum:  %lower%
if %compare%==%lower% (echo Files are same!) else (echo File was corrupted!)
pause
endlocal
goto end


::|||||||||||||||||||||||||||sha||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

:sha
cls
::User input for file path, and then getting a sha256 checksum and saving it to variable "compare"
setlocal enabledelayedexpansion
echo Input file path to be checked. No quotations around file path.
set /p thisPath=
set /a count=1 
for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%thisPath%" sha256') do (
  if !count! equ 1 set "compare=%%a"
  set/a count+=1
)
set "compare=%compare: =%
cls
echo %compare%
pause
endlocal
goto end


::|||||||||||||||||||||||||||CompareFiles|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

:compareFiles
cls
::User input for file path, and then getting a sha256 checksum and saving it to variable "compare"
setlocal enabledelayedexpansion
echo Input file path to be checked. No Quotations around file path.
set /p thisPath=
set /a count=1 
for /f "skip=1 delims=:" %%a in ('CertUtil -hashfile "%thisPath%" sha256') do (
  if !count! equ 1 set "compare=%%a"
  set/a count+=1
)
set "compare=%compare: =%
cls

::User input for file path, and then getting a sha256 checksum and saving it to variable "compare2"
echo Input file path for second file to be checked. No Quotations around file path.
set /p thisPath2=
set /a count=1 
for /f "skip=1 delims=:" %%b in ('CertUtil -hashfile "%thisPath2%" sha256') do (
  if !count! equ 1 set "compare2=%%b"
  set/a count+=1
)
set "compare2=%compare2: =%
cls

::Displaying both checksums and comparing them. USE LOWER CASE ONLY.
echo Path to file selected: %thisPath%
echo Path to second file: %thisPath2%
echo First SHA256 checksum is: %compare%
echo Second file checksum is:  %compare2%
if %compare%==%compare2% (echo Files are same!) else (echo File was corrupted!)
pause
endlocal
goto end

:end