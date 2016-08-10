Rem
	LAURA II
	Safety block out for Mac if the name of the Launcher is incorrect.
	
	
	
	(c) Jeroen P. Broks, 2016, All rights reserved
	
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
Version: 16.08.10
End Rem
'Print appfile

' WARNING!
' This file may ONLY be imported in the Mac version, or your game will NEVER work.
' All other platforms should skip this import.

Strict
Import tricky_units.prefixsuffix
Import brl.system

MKL_Version "LAURA II - MacNameBlockOut.bmx","16.08.10"
MKL_Lic     "LAURA II - MacNameBlockOut.bmx","GNU General Public License 3"

AppTitle = "LAURA LAUNCHER"
If Not Suffixed(AppFile,"Star Story.app/Contents/MacOS/Star Story")
	Notify "There are some name errors in the launcher name preventing secure work on Mac. Please make sure the names of the files are correctly set up."
	End
EndIf
