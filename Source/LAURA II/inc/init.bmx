Rem
	LAURA II
	Init the engine
	
	
	
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
MKL_Version "LAURA II - init.bmx","15.11.08"
MKL_Lic     "LAURA II - init.bmx","GNU General Public License 3"

Function Init()
Local Original = True
initID
InitConsoleText
InitPlatformScript
InitLoadGame Original
DefineSpecialChars
InitGraphics id,GraphicsFullScreen
'InitConsoleText
InitNetwork Original
InitDevelopment
InitLoading; Loading
InitClosure
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
	'Directive *DEVELOPMENT ' BLD: Compiler directive. If set it means you are running the Development version. The pre-processor can react to this if you use the -- @IF directive.
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
If FileType(swapdir)
	If Not DeleteDir(Swapdir,1) GALE_Error "Could not delete original swap dir!"
	EndIf
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
ErrorClosureMessage=id.Get("Error")+"\n"
If id.get("Dev")="Yes" 	
	ErrorClosureMessage:+"\n"+id.get("DevError")
	sessionlogfile = ExtractDir(SessionFile)+"/Session Log.html"
	ConsoleWriteLogFile(SessionLogFile$)
	EndIf
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
If fullscreen And startup.c("Windowed").toUpper()<>"YES" fullscreen = Proceed("We're running in debug mode.~n~nDo you want fullscreen?")
If fullscreen=-1 Bye
?
ConsoleWrite "Request to force Windowed mode is: "+ startup.c("Windowed")
If fullscreen And startup.c("Windowed").toUpper()<>"YES"
	For Local abit=EachIn bit
		If GraphicsModeExists(screenwidth,screenheight,abit)
			cbit = abit
			Print "Graphics mode: "+screenwidth+"x"+Screenheight+"; "+abit+"bit"
			CurrentGraphicsMode = Graphics(screenwidth,screenheight,cbit)
			SetBlend alphablend
			Kthura_GrabBoundaries	
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
Kthura_GrabBoundaries	 ' Let's see if this solves some evil
End Function	

Function InitScript()
Local IScript:TLua = GALE_LoadScript(JCR,"Script/Init/"+StartUp.C("StartScript"))
ConsoleWrite "Running Start up script..."; Print "Rinning Start Up Script..."
IScript.Run(StartUp.C("StartUpFunction"),Null)
End Function

Function LAURABYE()
ConsoleWrite "Killig session: "+Sessionfile
If Not DeleteFile(Dirry(Sessionfile)) GALE_Error "LAURA session not properly closed",[","+SessionFile,",this file could not be properly deleted ",",to mark the session is over.",",",",LAURA II will not be hurt by this",",but the launcher might malfunction.",",delete this file manually and stuff should work normally again"]	
ConsoleWrite "Session ended on: "+PNow()
ConsoleCloseLogFile()
GALE_Sys.ByeExecute
End Function

Function MacReturn()
?MacOS
If startup.C("MacReturn") Then
	EndGraphics
	Print "Returning to: "+startup.C("MacReturn")
	system_ startup.C("MacReturn")
	EndIf
?
End Function	

Function InitClosure()
ConsoleWrite "Setting up closure statements..."
If JCR_Exists(JCR,"Script/System/Bye.lua") GALE_Sys.AddByeScript("Script/System/Bye.lua")
'Notify "closure setting!" ' debug line
AddByeFunction LAURABYE
AddByeFunction MacReturn ' Only has effect on Mac. Other platforms will ignore this.
End Function

Function InitPlatformScript()
Local s$ = Platform_OS+"."+Platform_CPU
Local F$ = "Script/OSBOOT/"+s+".lua"
If Not JCR_Exists(JCR,f)
	ConsoleWrite "Not found boot file: "+f,255,0,0
	ConsoleCloseLogFile
	?Debug
	Notify "Not found: "+f
	?Not Debug
	Notify "Apparantly this game has no full support for platform: "+s
	?
	End
	EndIf
GALE_LoadScript(JCR,f)
End Function
	
