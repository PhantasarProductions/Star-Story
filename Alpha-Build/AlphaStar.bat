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
echo:   = Configuring git
md AlphaBuild
C:\"program files"\git\bin\git init AlphaBuild
cd AlphaBuild
C:\"program files"\git\bin\git remote add -f origin https://github.com/Tricky1975/Star-Story.git
C:\"program files"\git\bin\git config core.sparseCheckout true
echo Alphabuild/WindowsExe >> .git/info/sparse-checkout
echo Alphabuild/JCR >> .git/info/sparse-checkout
echo:   = Downloading game
C:\"Program Files"\git\bin\git pull origin master
echo:This file marks in installed version, so the installer will not install this game twice > Installed.txt
goto run

:pull
echo: - Updating
cd AlphaBuild
C:\"Program Files"\git\bin\git pull origin mastr
goto run

:run
echo: - Running the game
AlphaBUild\WindowsExe\"Star Story"




:bye
cd ..
echo: - Batch job ended
