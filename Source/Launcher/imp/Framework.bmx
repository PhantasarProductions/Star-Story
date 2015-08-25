Rem
/*
	Launcher - Star Story
	General framework the rest of the launcher should use
	
	
	
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


Version: 15.07.30

End Rem
Strict
Import maxgui.drivers
Import brl.linkedlist
Import bah.volumes
Import "JCRFile.bmx"

JCR6CrashError = True

?MacOS
Const winw = 800
Const winh = 800
?Win32
Const winw = 1200
Const winh = 800
?Linux
Const winw = 1200
Const winh = 800
?

Global Window:TGadget = CreateWindow("Star Story",0,0,winw,winh,Null,window_center|Window_clientcoords|Window_titlebar)
Global tabber:TGadget = CreateTabber(0,0,ClientWidth(window),ClientHeight(Window),window)
Global TW = ClientWidth(tabber)
Global TH = ClientHeight(tabber)
Global EID
Global ESource:TGadget
Global CPanel
Global allowcanvas,NoCanvas

Type TFPanelBase

	Field Panel:TGadget

	Method Flow() Abstract

	End Type
	
Global Panels:TList = New TList	

Function AddXPanel(Name$,TFPanel:TFPanelBase,Gadget:TGadget)
AddGadgetItem tabber,name
ListAddLast panels,TFPanel
TFPanel.Panel = Gadget
End Function

Function AddPanel:TGadget(Name$,TFPanel:TFPanelBase)
Local gadget:TGadget = CreatePanel(0,0,TW,TH,Tabber)
AddGadgetItem tabber,name
ListAddLast panels,TFPanel
TFPanel.Panel = Gadget
Return gadget
End Function

Function Flow()
Local P:TFPanelBase = TFPanelBase(Panels.valueatindex(CPanel))
If Not P 
	Print "No panel on "+CPanel
	Return
	EndIf'
P.flow()
End Function

Function Panel:TGadget(C)
Local tfp:TFPanelbase = tfpanelbase(panels.valueatindex(c))
Return tfp.panel
End Function

Function ShowPanel(C)
DebugLog "Showing panel: "+C
For Local ak=0 Until CountList(panels)
	panel(ak).setshow ak=c
	DebugLog "Panel("+ak+") = "+Int(c=ak)
	Next
End Function
