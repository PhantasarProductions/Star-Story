Rem
/*
	
	
	
	
	
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


Version: 15.07.12

End Rem
MKL_Version "LAURA II - inc/init.bmx","15.07.12"
MKL_Lic     "LAURA II - inc/init.bmx","GNU - General Public License ver3"

Function Init()
Local Original = True
initID
InitLoadGame Original
DefineSpecialChars
InitGraphics id,GraphicsFullScreen
InitConsoleText
InitNetwork Original
InitDevelopment
InitLoading; Loading
InitScript
InitShowMouseOrNot
'WaitKey ' Must be removed when init routines are complete!
End Function

Function InitShowMouseOrNot()
If Upper(id.Get("OSMousePointer"))="NO" Or Upper(id.Get("OSMousePointer"))="OFF" 
	HideMouse
	DebugLog "OS Mouse Pointer has been turned off"
	EndIf
End Function	

Function InitNetwork(O=True)
Local Original = O
If Not Original 
	ConsoleWrite "Not original from the start. Savegame issue?",255,0,0
	Return
	EndIf
For Local secu:TSecu=EachIn seculist
	original = Original And secu.Check(JCR,startup)
	Next
If Not original Return
For Local n:tnetwork = EachIn netlist
	ConsoleWrite "Logging in on "+n.Name()+" as "+n.User(startup)
	ConsoleShow
	Flip
	n.Login(startup)
	Next
End Function

Function InitDevelopment()
DevVersion = ID.Get("Dev").toUpper()="YES"
If DevVersion
	ConsoleWrite "Development Build",0,180,255
	IDirective "*DEVELOPMENT"
	' Info *DEVELOPMENT ' BLD: Compiler directive. If set it means you are running the Development version. The pre-processor can react to this if you use the -- @IF directive.
	EndIf
End Function

Function InitConsoleText()
ConsoleWrite "LAURA II - Coded by Tricky~n"
ConsoleWrite "(c) Jeroen P. Broks 2015~n"
ConsoleWrite "Released under the terms of the GNU General Public License version 3~n~n"
ConsoleWrite "Version: "+MKL_NewestVersion()+"~n~n"
For Local  lv$ = EachIn MKL_GetAllversions().split("~n") ConsoleWrite lv Next
ConsoleWrite "~n~n"
ConsoleWrite ""
LuaConsoleFlip = ID.Get("ShowConsole").toUpper()="YES"
If LuaConsoleFlip ConsoleShow; Flip
End Function

Function InitLoadGame(O Var) ' Load a saved game!
Local F$=Trim(startup.C("LoadGame"))
If Not F Return
If Chr(F[0])="*" Return
O = LoadGame(F$,O)
End Function

Function InitID()
id = LoadID(JCR,"ID/Identify")
If Not id error "Game has no identify data"
If id.get("Engine")<>"LAURA2" And id.get("Engine")<>"LAURA II" error "This game was meant for the "+id.get("Engine")+" engine and not for LAURA II"
LuaConsoleFlip = ID.Get("ShowConsole").toUpper()="YES"
AppTitle = id.get("Title")
End Function

Function InitGraphics(i:TID,fullscreen)
Local s$[]
EndGraphics
Delay 500
If i.get("Screen")
	s=i.get("Screen").split("x")
	If Len(s)<>2 error "No valid screen data set up for this game"
	EndIf
screenwidth = s[0].toint()
screenheight = s[1].toint()
Local bit[] = [32,24,16]
Local cbit
?debug
If fullscreen fullscreen = Proceed("We're running in debug mode.~n~nDo you want fullscreen?")
If fullscreen=-1 Bye
?
If fullscreen
	For Local abit=EachIn bit
		If GraphicsModeExists(screenwidth,screenheight,abit)
			cbit = abit
			Print "Graphics mode: "+screenwidth+"x"+Screenheight+"; "+abit+"bit"
			CurrentGraphicsMode = Graphics(screenwidth,screenheight,cbit)
			SetBlend alphablend
			Return
			EndIf
		Next
	Notify "You hardware appears to be unable to support "+screenwidth+"x"+ScreenHeight+" in full screen.~n~n~nIn stead LAURA II will run in windowed mode!"
	graphicsfullscreen = False
	EndIf
CurrentGraphicsMode = Graphics(screenwidth,screenheight,0)
SetBlend alphablend
DebugLog "OSMousePointer = "+i.Get("OSMousePointer")
Delay 1000
If Upper(i.Get("OSMousePointer"))="NO" Or Upper(i.Get("OSMousePointer"))="OFF" 
	HideMouse
	DebugLog "OS Mouse Pointer has been turned off"
	EndIf
End Function	

Function InitScript()
Local IScript:TLua = GALE_LoadScript(JCR,"Script/Init/"+StartUp.C("StartScript"))
ConsoleWrite "Running Start up script..."; Print "Rinning Start Up Script..."
IScript.Run(StartUp.C("StartUpFunction"),Null)
End Function
