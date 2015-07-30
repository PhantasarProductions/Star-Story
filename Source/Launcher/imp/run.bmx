Rem
/*
	Run the game
	
	
	
	
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


Version: 15.06.27

End Rem
Strict
Import "framework.bmx"

Global crashf$ = Dirry("$AppSupport$/StarStoryLauncherCrash")
JCR6CrashError = true

' Main
showpanel 0
Repeat
If FileType(crashf)
	DeleteFile crashf
	Bye
	EndIf
PollEvent
eid = EventID()
esource = TGadget(EventSource())
Select eid
	Case event_AppTerminate,event_windowclose
		Bye
	Case event_gadgetaction
		If esource=tabber
			cpanel = SelectedGadgetItem(esource)
			showpanel cpanel		
			EndIf
	Case event_gadgetpaint
		allowcanvas = True		
	End Select	
Flow
Forever
