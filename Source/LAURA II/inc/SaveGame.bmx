Rem
/*
	LAURA II - Savegame routines
	
	
	
	
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


Version: 15.07.20

End Rem

Function SaveGame(File$,DeleteMe=0)
' Create dir
Local FD$ = ExtractDir(SaveDir+"/"+File)
If FileType(FD)=1 GALE_Error "Cannot create a folder due to a file with the same name!"
If FileType(FD)=0 CreateDir FD,2; ConsoleWrite "Creating folder: "+FD,255,95,10
' Open
Local BT:TJCRCreate = JCR_Create(SaveDir+"/"+File)
Local K$
Local Save$
ConsoleWrite "Saving: "+file,255,95,10
'SSecuInit
' Check and save the Lua variables
GALE_SaveMSVars BT,"zlib","MS_Save/",True
'For K=EachIn MapKeys(GALE_MapMSSavedVars()) Ssecu "MS_Save/"+K,GALE_MapMSSavedVars().value(k) Next
' Save the gamevars
'ssecustringmap "M:Vars",LauraGameVars
SaveStringMap bt,"LAURA/Vars",LauraGameVars,"zlib"
' Sytem 
Save$ = "FullScreen = "+GraphicsFullScreen+"~n"
Save :+ "Flow = "+CurrentFlow$+"~n"
Save :+ "Maps.File = "+LAURA2Maps.CodeName+"~n"
Save :+ "Maps.Cam.X = "+LAURA2Maps.CamX+"~n"
Save :+ "Maps.Cam.Y = "+LAURA2Maps.CamY+"~n"
Save :+ "User = "+startup.C("User")+"~n"
If DeleteMe Then Save :+ "DeleteMe = true~n"
'ssecu "LAURA/System",save
bt.addstring save,"LAURA/System","zlib"
' Actors
Save = "-- Actors: "+LAURA2MAPS.CodeName+"~n~n"
For Local A:TKthuraActor = EachIn map.fullobjectlist
	If a.kind="Actor"
		Save$ :+"~n~nNEW"
		Save$ :+"~n~tTag = "+a.tag
		Save$ :+"~n~tx = "+a.x
		Save$ :+"~n~ty = "+a.y
		Save$ :+"~n~tLabels = "+a.labels
		Save$ :+"~n~tDominance = "+a.Dominance
		Save$ :+"~n~tR = "+a.R
		Save$ :+"~n~tG = "+a.G
		Save$ :+"~n~tB = "+a.B
		Save$ :+"~n~tAlpha = "+a.alpha
		Save$ :+"~n~tImpassible = "+a.Impassible
		For K=EachIn a.Data
			Save$ :+"~n~tData."+K+" = "+a.Data.Value(k)
			Next
		Save$ :+"~n~tSinglePic = "+a.singlepicfile
		save$ :+"~n~tPicBundle = "+a.picbundledir
		If a.picbundledir Save :+ "~n~tChosenPic = "+a.ChosenPic
		save$ :+"~n~tMoveSkip = "+a.moveskip
		save$ :+"~n~tFrameSpeed = "+a.FrameSpeed
		save  :+"~n~tVisible = "+a.visible
		save$ :+"~n~tWind = "+a.Wind
		EndIf
	Next
'ssecu "Map/Actors",save
bt.addstring save,"Map/Actors","zlib"
' Characters
'ssecu "P:Party",RPGStr()
RPGSave bt,"Party"
' Logindata
SaveNet bt,startup
' Swap files
If FileType(Swapdir)
	For Local F$=EachIn CreateTree(SwapDir)
		bt.addentry Swapdir+"/"+f,"SWAP/"+f
		Next
	EndIf
' Close
'SSecuDone BT
BT.Close "zlib"
Delay 50
SecuFile SaveDir+"/"+file
ConsoleWrite "Saving Complete",255,95,10
End Function

Function LoadGame(file$,Original)
ConsoleWrite "Loading: "+file,255,95,10
Local BD:TJCRDir = JCR_Dir(File)
Local ls$[]
Local DeleteWhenLoaded = False
' GameVars
LauraGamevars = LoadStringMap(BD,"LAURA/Vars")
VarReg LauraGameVars ' We need to register this again, or the game will use an empty map, this empty map will now be destroyed by the garbage collector.
' Party
RPGLoad BD,"Party"
' System
For Local line$=EachIn JCR_ListFile(BD,"LAURA/System")
	If line
		ls = line.split("=")	
		If Len ls<2 GALE_Error("LoadGame: System Syntax Error",["File,"+StripDir(File),"Line,"+line,"Len,"+Len(ls)])
		For Local ak=0 Until Len ls ls[ak]=Trim(ls[ak]) Next
		Select ls[0]
			Case "FullScreen"	graphicsfullscreen=ls[1].toint()
			Case "Flow"		currentflow = ls[1]
			Case "Maps.File"	LAURA2MAPS.Load ls[1]
			Case "Maps.Cam.X"	LAURA2MAPS.CamX = ls[1].toint()
			Case "Maps.Cam.Y" LAURA2MAPS.CAMY = ls[1].toint()
			Case "DeleteMe"	DeleteWhenLoaded = ls[1].tolower()="true"
			Case "User","UserName"
						If Not ls[1] ls[1]=StripAll(GetUserHomeDir())		
						startup.D("User",ls[1])
			Default		GALE_Error "LoadGame: Unknown variable",["File,"+file,"Variable,"+ls[0]]
			End Select
		EndIf
	Next
' Saved Lua Variables
ClearMap GALE_MapMSSavedVars()
For Local entry$=EachIn EntryList(BD)
	If Left(Entry,8)="MS_SAVE/" MapInsert GALE_MapMSSavedVars(),Right(entry,Len(entry)-8),JCR_LoadString(bd,entry)
	Next
' Actors
Map.RemoveActors
Local A:TKthuraActor
Local O:TKthuraObject
For Local Line$=EachIn JCR_ListFile(BD,"MAP/Actors")
	If line And Trim(Left(line,2))<>"--"
		If Trim(line)="NEW"
			a = New TKthuraActor
			a.parent = map
			a.Kind="Actor"
			For o=EachIn map.FullObjectList
				If o.IDNum>=a.idnum a.idnum=o.idnum+1
				Next
			ListAddLast map.fullobjectlist,a
			Print "Creating New Actor #"+a.idnum
		Else
			ls=Trim(line).split("=")
			For Local ak=0 Until Len ls ls[ak]=Trim(ls[ak]) Next
			Select Trim(ls[0])
				Case "Tag"		a.tag = ls[1]; DebugLog "We got an actor named: "+a.tag
				Case "x"		a.x = ls[1].toint()
				Case "y"		a.y = ls[1].toint()
				Case "Labels"	a.labels = ls[1].toint()
				Case "Dominance"	a.dominance = ls[1].toint()
				Case "R"		a.r = ls[1].toint()
				Case "G"		a.g = ls[1].toint()
				Case "B"		a.b = ls[1].toint()
				Case "Alpha"	a.Alpha = ls[1].todouble()
				Case "Impassible"	a.impassible = ls[1].toint()
				Case "SinglePic"	If ls[1] MAP.syncactorpics a,ls[1],0
				Case "PicBundle"	If ls[1] MAP.syncactorpics a,ls[1],1
				Case "ChosenPic"	a.chosenpic = ls[1]
				Case "MoveSkip"	a.moveskip = ls[1].toint()
				Case "FrameSpeed"	a.framespeed = ls[1].toint()
				Case "Framespeed"	a.framespeed = ls[1].toint() ' Just needed as a "dirty" fix for an old bug. Will very likely be removed later.
				Case "Wind"		a.wind = ls[1]
				Case "Visible"	a.visible = ls[1].toint()
				Default		GALE_Error "Unknown actor variable: "+ls[0]
				End Select
			EndIf
		EndIf
	Next	
map.totalremap
' Swap files
If FileType(Swapdir)
	If Not DeleteDir(Swapdir,1) GALE_Error "Could not delete original swap dir!"
	EndIf
Local Ent:TJCREntry
Local OSFile$ ' Output Swap file... Not Operating system :-P
For Local E$ = EachIn EntryList(BD)
	If Prefixed(E,"SWAP/")
		Ent = JCR_Entry(BD,E$)
		OSFile = Swapdir + Right(Ent.FileName,Len(Ent.FileName)-5)
		If Not CreateDir(ExtractDir(OSFile),1) GALE_Error "Could not create output folder to create swapfile: "+OsFile
		JCR_Extract BD,E,OSFile,1
		EndIf
	Next
' Network data
LoadNet BD,startup						
' Security check
Original = LSecu(BD)
Print "Original = "+Original
'ConsoleShow;Flip;WaitKey;Bye ' Debug line. Put on rem when done.
' If this is a "DeleteMe" savegame, remove it now	
If DeleteWhenLoaded 
	If Not DeleteFile(file) GALE_Error "Deletion Error",["1,This file had to be deleted after loading","2,however, either it's been tampered with","3,somehow or there are some filesystem","4,errors, but the deletion failed.","5,","6,In order not to enable cheating","7,the system's gonna crash out!","8,Bye!"]
	EndIf
Return Original
End Function
