Rem
	Star Story Launcher
	Simple program to correctly start a new game or load a savegame
	
	
	
	(c) Jeroen P. Broks, 2015, All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
Version: 15.11.08
End Rem
Strict

Framework tricky_units.MKL_Version

Import "imp/JCR6Crash.bmx"
Import "imp/DeleteCrash.bmx"


?win32
Import "Wendicka.o"
?
Import "imp/LauncherIni.bmx"
Import "imp/JCRFile.bmx"

' Panels
Import "imp/IntroPanel.bmx"
Import "imp/NewGame.bmx"
Import "imp/LoadGame.bmx"
Import "imp/versions.bmx"


'Flow
Import "Imp/Run.bmx"

MKL_Version "LAURA II - Star Story.bmx","15.11.08"
MKL_Lic     "LAURA II - Star Story.bmx","GNU General Public License 3"
