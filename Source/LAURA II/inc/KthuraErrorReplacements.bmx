Rem
	LAURA II
	Error handler for Kthura
	
	
	
	(c) Jeroen P. Broks, 2015, 2016, All rights reserved
	
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
Version: 16.02.06
End Rem
Function RK_Error(E$)
ConsoleWrite "* KTHURA MAP SYSTEM ERROR *",255,0,0
ConsoleWrite E,255,180,0
ConsoleWrite "Hit any key to . . .",0,180,255
ConsoleShow
Flip
FlushKeys
WaitKey
Bye
End Function

Function RK_Warn(E$)
ConsoleWrite "* KTHURA MAP SYSTEM WARNING *",255,0,0
ConsoleWrite E,255,180,0
End Function

KthuraError = RK_Error
KthuraWarning = RK_Warn

MKL_Version "LAURA II - KthuraErrorReplacements.bmx","16.02.06"
MKL_Lic     "LAURA II - KthuraErrorReplacements.bmx","GNU General Public License 3"
