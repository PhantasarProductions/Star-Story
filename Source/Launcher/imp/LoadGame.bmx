Rem
/*
	Star Story - Load Game
	If Not ch 
		GALE_Error("Character doesn't exist",["F,RPGChar.SetData","char,"+char])
		EndIf

	Load savegame screen for Star Story
		GALE_Error("Character doesn't exist",["F,RPGChar.SetData","char,"+char])
		EndIf

	
	
	
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
Strict

Import tricky_units.ListDir
Import tricky_units.Dirry
Import tricky_units.advdatetime
Import "Framework.bmx"

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
	Field IgnoreGameJolt:TGadget
	Field OldMinute ',OldUser$,OldFile$
	Field User$,CFile$
	Field YesNo$[] = ["No","Yes"]
		
	Method Make()
	Crystal = CreatePanel(TW-CW,TH-CH,CW,CH,panel)
	SetGadgetPixmap Crystal,PixCrystal
	Go = CreateButton("Load Game",CW-150,CH-25,150,25,Crystal,Button_ok)
	CreateLabel "Users:",0,0,600,25,panel
	Users = CreateListBox(0,25,600,75,Panel)
	CreateLabel "Files:",0,100,600,25,panel
	Files = CreateListBox(0,125,600,600,Panel)
	' Get the users
	CreateDir Dirry(Save),2
	GetUsers()
	oldminute = Minute()
	made = True
	IgnoreGameJolt:TGadget = CreateButton("Ignore GameJolt",0,CH-25,250,25,panel,Button_checkbox)
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

	
	Method RunLoadGame(File$)
	Print "Setting up LAURA II to load game: "+File
	Local syscommand$
	Local platform$
	?MacOS
	platform = "Mac"
	syscommand = "open "+lini.c("Mac")
	?Win32
	platform = "Windows"
	syscommand = lini.c("Windows")
	?Linux
	platform = "Linux"
	syscommand = lini.c("Linux")
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
	WriteLine bt,"Var:StartScript=LoadGame.lua"
	WriteLine bt,"Var:Title=Star Story"
	WriteLine bt,"Var:StartUpFunction=LoadGame"
	WriteLine Bt,"Var:CodeName=StarStory"
	If IgnoreGameJolt WriteLine bt,"Var:IgnoreGameJolt="+YesNo[ButtonState(IgnoreGameJolt)]
	CloseStream BT
	?Not MacOS
	HideGadget window
	?
	Print "Executing: "+syscommand
	system_ syscommand
	?Not MacOS
	Refresh User,cfile
	ShowGadget Window
	?	
	End Method
	
	Method flow()
	Local U ',User$
	Local F ',File$	
	If Not made make
	'U = SelectedGadgetItem(Users)
	Files.setenabled SelectedGadgetItem(Users)>=0
	Go.setenabled SelectedGadgetItem(Users)>=0 And SelectedGadgetItem(Files)>=0
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
				Case Files,Go
					U = SelectedGadgetItem(users)
					F = SelectedGadgetItem(Files)
					If U>=0 And F>=0
						User  = GadgetItemText(Users,U)
						cfile = GadgetItemText(Files,F)
						RunLoadGame Dirry(Save)+"/"+User+"/"+CFile
						EndIf
				End Select		
		End Select
	'olduser = user
	'oldfile = file	
	'setcaption window,"Old Minute: "+OldMinute+"; True Minute: "+Minute() ' debug line
	If oldminute<>Minute() Refresh user,cfile
	'SetGadgetText Window,cfile
	End Method
	
	End Type

