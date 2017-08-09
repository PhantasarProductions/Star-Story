Rem
	Launcher - Star Story
	Run the launcher
	
	
	
	(c) Jeroen P. Broks, 2015, 2016, 2017, All rights reserved
	
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
Version: 17.06.19
End Rem
Strict
'Import "framework.bmx"
Import "LoadGame.bmx"



Global crashf$ = Dirry("$AppSupport$/StarStoryLauncherCrash")
JCR6CrashError = True

Type TSystemFile
	Field Panel:TGadget
	Field Load:TGadget
	Field Del:TGadget
	Field File$
	End Type
	
Global LSystemFile:TList = New TList
	
Function CreateSystemFile(File$,Description$,Explain$)
Local SF:TSystemFile = New tsystemfile
sf.panel = CreatePanel(0,0,ClientWidth(tabber),ClientHeight(tabber),tabber); HideGadget sf.panel
CreateLabel "The ~q"+Description+"~q file has been found.~n~n"+Explain+"~n~nDo you wish to load or delete this file?",0,0,TW,TH/2,sf.panel
sf.Load = CreateButton("Load"  ,(tw/2)-200,th/2,200,25,sf.panel)
sf.del  = CreateButton("Delete",(tw/2)    ,th/2,200,25,sf.panel)
HideGadget sf.panel
sf.File = Dirry(Save)+"/System/"+File
ListAddLast Lsystemfile,sf
End Function

?MacOS
Rem due to the new setup, this part is no longer required
Function MacSessionKill()
'Notify "MacSessionKill set up" ' Debug line
Local file$ = Dirry("$AppSupport$/$LinuxDot$Phantasar Productions/LAURA2/StarStory/Session.txt")
Local SF:TSystemFile = New tsystemfile
sf.panel = CreatePanel(0,0,ClientWidth(tabber),ClientHeight(tabber),tabber)
CreateLabel "It appears the game is in session. Don't use this launcher as long as the session goes.~n~nIf there is no session running then it might be possible the last session is not properly shut down. I can kill the session forcefully, however if a real session is running nevertheless it will terminate itself in less than 60 seconds without any futher warning.~n~nIf the game is running fine, you shouldn't bother. :) ",0,0,TW,TH/2,sf.panel
sf.del  = CreateButton("Kill Session",(tw/2)-100    ,th/2,200,25,sf.panel)
HideGadget sf.panel
sf.File = File
ListAddLast Lsystemfile,sf
'Notify "Session file = "+file ' Debug line
End Function

MacSessionKill
End Rem
?

CreateSystemFile "Emergency","Emergency Save","Perhaps you did not properly quit the game last time you played. Maybe there was an error in the game? Or a total OS crash? Or did you have a power malfunction? Or did you just forget to shutdown the game? Anyway here we got an emergency save so maybe you can load it to recover some unsaved data."
CreateSystemFile "Quit Game","Save upon quitting","Last time you quit the game (maybe in a hurry) and you left this savegame."

Function SystemFilesCheck()
Local ShownPanel:TGadget = Null
For Local SF:TSystemfile = EachIn lsystemfile
	'Notify "Checking for "+(Dirry(Save)+"/System/"+sf.file)+" resulted into: "+FileType(Dirry(Save)+"/System/"+sf.file) ' debug line
	If FileType(sf.file) And (Not ShownPanel) And cpanel<>0 ShownPanel=sf.panel Else HideGadget sf.panel
	If eid=event_gadgetaction
		Select ESource
	 		Case sf.Load	LoadGame	sf.file; HideGadget ShownPanel; showpanel cpanel; Return
			Case sf.del		DeleteFile	sf.file; HideGadget ShownPanel; showpanel cpanel; Return
			End Select
		EndIf	
	'sf.panel.setshow showpanel=sf.panel
	'tabber.setshow showpanel=tabber		
	Next	
'If showpanel<>tabber 	
'	For Local pan:TFPanelBase=EachIn panels HideGadget pan.panel Next
'	EndIf
showforcedpanel ShownPanel
If Not shownpanel cpanel = SelectedGadgetItem(tabber) showpanel cpanel 
Return shownpanel<>Null	
End Function


' Main
LoadConfig
showpanel 0
Repeat
If FileType(crashf)
	DeleteFile crashf
	Bye
	EndIf
PollEvent
eid = EventID()
esource = TGadget(EventSource())
edata = EventData()
NoCanvas = SystemFilesCheck()
Select eid
	Case event_AppTerminate,event_windowclose
		SaveConfig
		Bye
	Case event_gadgetaction
		If esource=tabber And (Not nocanvas)
			cpanel = SelectedGadgetItem(esource)
			showpanel cpanel		
			EndIf
	Case event_gadgetpaint
		allowcanvas = True
	Case event_menuaction
		If edata>=999 
			End
		Else
			SelectGadgetItem tabber,edata
			showpanel edata
		EndIf	
	End Select	
'ALLOWCANVAS = ALLOWCANVAS And (Not NOCANVAS)	
Flow
Forever
