@echo off
echo off
rem The second "echo off" command is to make sure the echo is off, as the "@" prefix is should be supported in all official versions of Windows, but if you use something like a "windows clone" I cannot guarantee that :)

if exist "C:\program files\Git\bin\git.exe" goto gitfound
echo "* ERROR *"
echo " Git could not be found, or at least not in the place where I expected it"
goto bye


:gitfound
if exist "Installed.txt" goto pull
echo: - Installing Star Story Alpha
echo:   = Initializing git
md AlphaBuild
C:\"program files"\git\bin\git init AlphaBuild
cd AlphaBuild
echo   = Analysing git repository
C:\"program files"\git\bin\git remote add -f origin https://github.com/Tricky1975/Star-Story.git
echo   = Configuring git
echo Alpha-Build/WindowsExe/>> .git/info/sparse-checkout
echo Alpha-Build/JCR/>> .git/info/sparse-checkout
echo   = Checkout folders
type .git\info\sparse-checkout
C:\"program files"\git\bin\git config core.sparseCheckout true
echo   = Downloading game
C:\"Program Files"\git\bin\git pull origin master
cd ..
echo "This file marks in installed version, so the installer will not install this game twice" > Installed.txt
goto run

:pull
echo - Updating
cd AlphaBuild
C:\"Program Files"\git\bin\git pull origin master
cd ..
goto run

:run
echo - Running the game
Alpha-Build\WindowsExe\"Star Story"




:bye
echo - Batch job ended
