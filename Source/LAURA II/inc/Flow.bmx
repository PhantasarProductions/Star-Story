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


Version: 15.07.27

End Rem
Function RunFlow() 
Repeat
If GALE_INP.AutoGrab Grabinput 
LAURA_API.Terminate =  GALE_INP.Terminate 'AppTerminate()
If Not currentflow GALE_Error "No flow"
GALE_MS.Run CurrentFlow,"MAIN_FLOW"
If DevVersion And GALE_INP.KeyH(KEY_F1) DevConsole()
Forever
End Function




Function DevConsole()
Local X 
FlushKeys
Repeat
ConsoleShow
Flip
X = WaitChar()
If X>=32 ConsoleCommand:+Chr(X) Else
	Select X
		Case 8 If ConsoleCommand ConsoleCommand = Left(ConsoleCommand,Len(ConsoleCommand)-1)
		Case KEY_UP ConsoleCommand = LastConsoleCommand
		Case 13
			ConsoleWrite ">"+ConsoleCommand
			LastConsoleCommand = ConsoleCommand
			ConsoleCommand=""
			FlushKeys
			ConsoleExecute LastConsoleCommand
		End Select
Until X=KEY_ESCAPE
FlushKeys
End Function

Function DevConsoleInput$()
ConsoleCommand=""
Local ret$,x
Repeat
ConsoleShow
Flip
X = WaitChar()
If X>=32 ConsoleCommand:+Chr(X) Else
	Select X
		Case 8 If ConsoleCommand ConsoleCommand = Left(ConsoleCommand,Len(ConsoleCommand)-1)
		Case KEY_UP ConsoleCommand = LastConsoleCommand
		Case 13
			ConsoleWrite ">"+ConsoleCommand,0,180,255
			ret = ConsoleCommand
			ConsoleCommand=""
			FlushKeys
		End Select
Until X=13
Return ret
End Function


Function ConsoleExecute(Command$)
Local C$ = Trim(Command)
Local Cmd$,Para$[]
Local s = C.find(" ")
If s<0
	Cmd = Upper(C)
	Para = Null
Else
	Cmd = Upper(c[..s])
	Para = Trim(c[s..]).split(",")
	EndIf
Select cmd
	Case "SAY"
		If Not Para 
			ConsoleWrite "? No parameters",255,0,0
		Else
			For Local P$=EachIn Para ConsoleWrite VarStr(P) Next
			EndIf
	Case "MSVARS"
		For Local f$=EachIn MapKeys(GALE_MapMSSavedVars())
			ConsoleWrite f,0,180,255
			For Local l$=EachIn GALE_MapMSSavedVars().Value(f).split("~n")
				ConsoleWrite "  "+l,255,180,0
				Next
			Next	
		ConsoleWrite "Ok",0,255,180	
	Case "DEF"
		If Not Para 
			ConsoleWrite "? No parameters",255,0,0
			Return
		ElseIf Len(Para)<>2
			ConsoleWrite "Incorrect number of parameters",255,0,0
			Return
			EndIf
		VarDef Para[0],Para[1]			
	
	Case "BYE","EXIT","QUIT"
		Bye
	Default
		If Not ConsoleScript 
			' ConsoleScript = GALE_LoadScript(JCR,"Script/System/Console.lua"); GALE_AddScript "*SYSTEM*",ConsoleScript
			GALE_MS.Load("*SYSTEM*","Script/System/Console.lua")
			consolescript = GALE_GetScript("*SYSTEM*")
			EndIf
		If Not ListContains(Consolescript.functions,Cmd)
			ConsoleWrite "? No function named "+Cmd+" has been found either internally or in the script",255,0,0
		Else
			consolescript.run Cmd,para
		EndIf
	End Select			
End Function
