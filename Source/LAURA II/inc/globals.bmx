Rem
/*
	LAURA II
	Global declaraions
	
	
	
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
*/


Version: 15.08.26

End Rem
MKL_Version "LAURA II - inc/globals.bmx","15.08.26"
MKL_Lic     "LAURA II - inc/globals.bmx","GNU - General Public License ver3"

' Dirs
Const AppSupportDir$ = "$AppSupport$/$LinuxDot$Phantasar Productions/LAURA2/"
Const sstartupfile$ = appsupportdir + "LAURA2run.ini"

Global SaveDir$ ' Defined during the start up
Global SwapDir$ ' Defined during the start up
Global CMapDir$ ' Defined during the start up

' Start up
Global StartUp:TIni

' Graphics
Global CurrentGraphicsMode:TGraphics
Global GraphicsFullScreen = True
Global ScreenWidth=640
Global ScreenHeight=480


' JCR
Global JCR:TJCRDir = New TJCRDir

' ID
Global ID:TID

' Loading
Global LoadingImg:TImage
Global LoadingX,LoadingY

' Game Vars
Global LauraGameVars:StringMap = New StringMap
VarReg LauraGameVars

' Game Maps
Global Map:TKthura
Global MapPatchLoaded
Global MapListOnlyLabels:TList
Global MapArrayOnlyLabels$[]

' Flow
Global CurrentFlow$

' Dev version
Global DevVersion = False
Global LastConsoleCommand$
Global ConsoleScript:TLua

' Session
Global SessionFile$
