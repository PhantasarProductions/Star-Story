Rem
	Launcher - Star Story
	Load a saved game
	
	
	
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
Version: 16.02.01
End Rem
Strict

Import tricky_units.ListDir
Import tricky_units.Dirry
Import tricky_units.advdatetime
Import tricky_units.Bye
Import "Framework.bmx"

MKL_Version "LAURA II - LoadGame.bmx","16.02.01"
MKL_Lic     "LAURA II - LoadGame.bmx","GNU General Public License 3"


JCR6CrashError = True

Const save$ = "$AppSupport$/$LinuxDot$Phantasar Productions/LAURA2/StarStory/Saved Games"

Private
Global GLGPanel:tloadgamepanel = New TLoadGamePanel
Public
Global LGPanel:TGadget = AddPanel("Load Game",GLGPanel)

Function LoadGame(file$)
GLGPanel.RunLoadGame File
End Function

Type TLoadGamePanel Extends tfpanelbase

	Field made = False
	Field PixCrystal:TPixmap = LoadPixmap(JCR_B(JCR,"GFX/Intro/Crystal.png"))
	Field CW = PixmapWidth(PixCrystal)
	Field CH = PixmapHeight(PixCrystal)
	Field Crystal:TGadget
	Field Users:TGadget
	Field Files:TGadget
	Field Go:TGadget
	Field Sync:TGadget
	Field IgnoreGameJolt:TGadget
	Field OldMinute ',OldUser$,OldFile$
	Field User$,CFile$
	Field YesNo$[] = ["No","Yes"]
	Field RefreshButton:TGadget ' Only used on Mac
	Field WINDOWED:TGadget
		
	Method Make()
	If Month()=12 And Day()>=25 PixCrystal = LoadPixmap(JCR_B(JCR,"GFX/Intro/CrystalXMas.png"))
	Crystal = CreatePanel(TW-CW,TH-CH,CW,CH,panel)
	SetGadgetPixmap Crystal,PixCrystal
	?Not MacOS
	Go = CreateButton("Load Game",0,CH-25,CW,25,Crystal,Button_ok)
	Sync = CreateButton("Synchronize",0,CH-60,CW,25,Crystal)
	?
	?MacOS
	Go = CreateButton("Load Game",CW-150,CH-25,150,25,Crystal,Button_ok)
	Sync = CreateButton("Synchronize",CW-150,CH-50,150,25,Crystal)
	RefreshButton = CreateButton("Refresh",CW-150,CH-75,150,25,Crystal)
	?
	CreateLabel "Users:",0,0,600,25,panel
	Users = CreateListBox(0,25,600,75,Panel)
	SetGadgetColor Users,0,30,40,1
	SetGadgetColor Users,0,180,255,0
	CreateLabel "Files:",0,100,600,25,panel
	Files = CreateListBox(0,125,600,600,Panel)
	SetGadgetColor Files,40,30,0,1
	SetGadgetColor files,255,180,0,0
	' Get the users
	CreateDir Dirry(Save),2
	GetUsers()
	oldminute = Minute()
	made = True
	IgnoreGameJolt:TGadget = CreateButton("Ignore GameJolt",0,CH-25,250,25,panel,Button_checkbox)
	Windowed:TGadget = CreateButton("Windowed",250,CH-25,250,25,panel,Button_checkbox)
	MGIF_RegisterGadget "GameJolt.Ignore",IgnoreGAMEJOLT
	MGIF_RegisterGadget "Load.Windowed",Windowed
	MGIF_RegisterGadget "Load.User",Users
	MGIF_RegisterGadget "Load.File",Files
	MGIF_GetConfig Config
	If Config.C("Load.File")
		getusers Config.C("Load.User"),Config.C("Load.File")
	ElseIf Config.C("Load.User")
		getusers Config.C("Load.User")
		EndIf
	End Method
	
	Method GetUsers(SUSER$="",SFILE$="")
	Local i=-1,c=-1
	ClearGadgetItems users
	ClearGadgetItems files
	For Local U$=EachIn ListDir(Dirry(Save),2)
		If Upper(U)<>"SYSTEM"
			AddGadgetItem Users,U
			c:+1
			If SUSER And SUSER=U i=c
			EndIf
		Next
	If i>-1 
		SelectGadgetItem Users,i	
		GetFiles SUSER,SFILE
		EndIf
	End Method
	
	Method GetFiles(User$,SFILE$="")
	ClearGadgetItems Files
	Local i=-1,c=-1
	For Local F$=EachIn ListDir(Dirry(Save)+"/"+User,1)
		AddGadgetItem Files,F 
		c:+1
		If SFILE And SFILE=F i=c
		DebugLog "SFILE = "+SFILE+"; F = "+F+"; i = "+i+"; c = "+c
		Next
	If i>-1 
		SelectGadgetItem Files,i	
		EndIf
	End Method
	
	Method Refresh(pOldUser$,pOldFile$)
	GetUsers pOldUser,pOldFile
	OldMinute = Minute()
	End Method

	
	Method RunLoadGame(File$,Sync=0)
	Print "Setting up LAURA II to load game: "+File
	Local syscommand$
	Local platform$
	Local fun$[] = ["LoadGame","Synchronize"]
	Local lua$[] = ["LoadGame","Synchronize"]
	?MacOS
	platform = "Mac"
	syscommand = "open ~q"+lini.c("Mac")+"~q"
	?Win32
	platform = "Windows"
	syscommand = "~q"+lini.c("Windows")+"~q"
	?Linux
	platform = "Linux"
	syscommand = "~q"+lini.c("Linux")+"~q"
	?
	Print "Detected platform: "+platform
	CreateDir Dirry("$AppSupport$/$LinuxDot$Phantasar Productions/LAURA2"),2
	Local BT:TStream = WriteFile(Dirry("$AppSupport$/$LinuxDot$Phantasar Productions/LAURA2/LAURA2run.ini"))	
	If Not BT
		Notify "Unable to write the initiation data the LAURA II engine needs to start up."
		Return
		EndIf
	WriteLine bt,"Add:Resource,"+lini.c("Resource")
	WriteLine bt,"Var:LoadGame="+File
	WriteLine bt,"Var:StartScript="+lua[sync]+".lua"
	WriteLine bt,"Var:Title=Star Story"
	WriteLine bt,"Var:StartUpFunction="+fun[sync]
	WriteLine Bt,"Var:CodeName=StarStory"
	?MacOS
	Local A$ = AppFile
	While ExtractExt(A).toupper()<>"APP" a = ExtractDir(A) Wend
	Print "LAURA II will return to "+A+" when finished!"
	WriteLine bt,"Var:MacReturn="+Replace(A," ","\ ")
	?	
	If IgnoreGameJolt And (Not Sync) WriteLine bt,"Var:IgnoreGameJolt="+YesNo[ButtonState(IgnoreGameJolt) And (Not Sync)]
	If Sync Or ButtonState(windowed) WriteLine BT,"Var:Windowed=Yes"
	CloseStream BT
	SaveConfig
	?Not MacOS
	HideGadget window
	?
	Print "Executing: "+syscommand
	Notify "Executing: "+syscommand
	system_ syscommand
	?Not MacOS
	Refresh User,cfile
	ShowGadget Window
	?	
	?MacOS
	If Not Sync Bye
	?
	End Method
	
	Method flow()
	Local U ',User$
	Local F ',File$	
	If Not made make
	'U = SelectedGadgetItem(Users)
	Files.setenabled SelectedGadgetItem(Users)>=0
	Go.setenabled    SelectedGadgetItem(Users)>=0 And SelectedGadgetItem(Files)>=0
	Sync.SetEnabled  SelectedGadgetItem(Users)>=0 And SelectedGadgetItem(Files)>=0
	Select EID
		Case event_gadgetselect
			Select ESource
				Case Users
					ClearGadgetItems files
					U = SelectedGadgetItem(Users)
					If U>=0
						User = GadgetItemText(Users,U)
						GetFiles User
					Else
						ClearGadgetItems files
						EndIf
				Case Files
					U = SelectedGadgetItem(users)
					F = SelectedGadgetItem(Files)
					If U>=0 And F>=0
						User  = GadgetItemText(Users,U)
						cfile = GadgetItemText(Files,F)
						EndIf
				EndSelect
		Case Event_GadgetAction
			Select ESource
				Case Files,Go,Sync
					If ESource=Sync 
						If Proceed("This synchronizer will try to synchronize all your achievement to GameJolt.~n~nThis feature has come to life for two possible scenarios:~n-~tIf your login times take too long you may want to skip login~n~tfor most loads, and sync your achievements every once in awhile.~n-~tIf loggin in failed you may continue play and use this~n~tfeature to get your achiements synchronized.~n~nI cannot tell how long this synchronization will take (and this is also depended on how many you already obtained. Best is not to do this when you are in a hurry).~n~nContinue ?")<>1 Return
						EndIf
					U = SelectedGadgetItem(users)
					F = SelectedGadgetItem(Files)
					If U>=0 And F>=0
						User  = GadgetItemText(Users,U)
						cfile = GadgetItemText(Files,F)
						RunLoadGame Dirry(Save)+"/"+User+"/"+CFile,ESource=Sync
						EndIf
				?MacOS		
				Case RefreshButton
					Refresh User,CFile
				?	
				End Select		
		End Select
	'olduser = user
	'oldfile = file	
	'setcaption window,"Old Minute: "+OldMinute+"; True Minute: "+Minute() ' debug line
	If oldminute<>Minute() Refresh user,cfile
	'SetGadgetText Window,cfile
	End Method
	
	End Type

