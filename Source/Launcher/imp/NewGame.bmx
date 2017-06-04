Rem
	Launcher - Star Story
	Start a new game
	
	
	
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
Version: 16.08.16
End Rem
Strict
Import "framework.bmx"
Import tricky_units.Dirry
Import tricky_units.Bye
Import tricky_units.anna ' This may only be used in unmodified versions of the game!
Import tricky_units.MD5

Private
Function Anna:StringMap(q$)
Return Anna_Request(Q) ' If you are compiling a modified version, remove this line or put it on REM, as ANNA may ONLY be used on unmodified versions of the game. If you only enhanced the launcher and only allowed the launcher to create a new account or to check if an account exists (as that is all the launcher may do), I will allow you to keep it.
End Function
Public


MKL_Version "LAURA II - NewGame.bmx","16.08.16"
MKL_Lic     "LAURA II - NewGame.bmx","GNU General Public License 3"

JCR6CrashError = True
Global NGPanel:TGadget = AddPanel("New Game",New TNewGamePanel)

Global ReservedNames$[] = ["SYSTEM"]


Type TNewGamePanel Extends tfpanelbase

	Field Made = False
	Field NGP:TGadget 
	Field StartNewGame:TGadget 
	Field StartNewGamePlus:TGadget 
	Field YourName:TGadget
	Field Languages:TGadget
	Field PixWendicka:TPixmap = LoadPixmap(JCR_B(JCR,"GFX/Intro/Wendicka.png"))
	Field PanWendicka:TGadget
	Field StartGame:TGadget
	Field GameJoltUserName:TGadget
	Field GameJoltToken:TGadget
	Field AnnaID:TGadget
	Field AnnaSecu:TGadget
	Field AnnaCreate:TGadget
	Field Skill:TGadget
	Field Windowed:TGadget
	Field SkipGameJolt:TGadget
	Field GJWhatsthis:TGadget
	Field AnnaWhatsthis:TGadget
	Field YesNo$[] = ["No","Yes"]

	Method Build()
	CreateLabel "Start: ",0,0,300,25,panel
	'?Not Win32
	If bigenough	
		panwendicka = CreatePanel(tw-PixmapWidth(pixwendicka),th-PixmapHeight(pixwendicka),PixmapWidth(pixwendicka),PixmapHeight(pixwendicka),panel)
		startgame = CreateButton("Start Game",ClientWidth(panWendicka)-100,ClientHeight(PanWendicka)-25,100,25,panwendicka)
		SetGadgetPixmap panwendicka,pixwendicka
	Else
		panWendicka=panel
		startgame=CreateButton("Start Game",ClientWidth(panel)-100,ClientHeight(Panel)-25,100,25,panel)
	EndIf	
	'?
	NGP =  CreatePanel(300,0,300,50,panel)
	StartNewGame = CreateButton("New Game",0,0,300,25,NGP,button_radio)
	StartNewGamePlus = CreateButton("New Game +",0,25,300,25,NGP,Button_radio)
	SetButtonState StartNewGame,True
	startnewgameplus.setenabled False
	HideGadget StartnewGame
	HideGadget startnewgameplus 
	' This is now handled differently.
	CreateLabel "Your name: ",0,50,300,25,panel
	yourname = CreateTextField(300,50,300,25,panel)
	SetGadgetText yourname,StripAll(GetUserHomeDir())
	CreateLabel "Scenario Language:",0,75,300,25,Panel
	languages = CreateListBox(300,75,300,100,panel)
	MGIF_RegisterGadget "Language",Languages
	Local E:TJCREntry,Lang$
	For Local F$=EachIn MapKeys(JCR.Entries)
		If StripDir(F)="SETTINGS" And ExtractDir((ExtractDir(F))) = "LANGUAGES"
			e = TJCREntry(MapValueForKey(JCR.Entries,F))
			Lang$ = StripDir(ExtractDir(e.filename))
			AddGadgetItem languages,lang
			EndIf
		Next
	CreateLabel "Difficulty:",0,175,300,25,Panel
	Skill = CreateListBox(300,175,300,75,Panel)
	AddGadgetItem skill,"Beginner"
	AddGadgetItem skill,"Casual Gamer"
	AddGadgetItem skill,"No Life Gamer"  
	SelectGadgetItem skill,1
	CreateLabel "Start up flags:",0,275,300,25,Panel
	windowed = CreateButton("Windowed",300,275,300,25,Panel,Button_CheckBox)
	SkipGameJolt = CreateButton("Skip GameJolt",300,300,300,25,Panel,Button_CheckBox)
	
	'CreateLabel "GameJolt Login. If you don't have a GameJolt account, simply leave the fields below blank",0,375,400,50,Panel
	CreateLabel "Game Jolt login (optional)",0,375,250,25,panel
	GJWhatsthis = CreateButton("What's this?",250,375,150,25,panel)
	CreateLabel "UserName:",0,400,300,25,Panel
	CreateLabel "Token:",0,425,300,25,Panel
	GameJoltUserName = CreateTextField(300,400,300,25,Panel)
	GameJoltToken = CreateTextField(300,425,300,25,panel,textfield_password)
	Gamejoltusername.setenabled JCR_Exists(JCR,"Authenticate/GameJolt")
	gamejolttoken.setenabled JCR_Exists(JCR,"Authenticate/GameJolt")
	made = True
	MGIF_RegisterGadget "GameJolt.UserName",GameJoltUserName
	MGIF_RegisterGadget "GameJolt.Token",GameJoltToken	
	MGIF_GetConfig Config
	Rem
	CreateLabel "Anna Login. If you have an Anna account, your achievements will be logged on the Phantasar Productions Website",0,500,400,50,Panel
	CreateLabel "If you don't have or want an Anna account you can skip this part.",0,550,400,25,panel
	CreateLabel "If your Anna Account is tied to your GameJolt account, can don't have to log this game itself in on GameJolt, but doing so anyway is harmless",0,600,400,50,panel
	End Rem
	CreateLabel "Anna Login: (optional)",0,475,250,25,panel
	AnnaWhatsthis = CreateButton("What's this?",250,475,150,25,panel)	
	CreateLabel "Account id:",0,500,200,25,panel
	CreateLabel "Secu-Code: ",0,525,200,25,panel
	AnnaID = CreateTextField(300,500,50,25,panel)
	AnnaSecu = CreateTextField(300,525,200,25,panel)
	AnnaCreate = CreateButton("Create",375,500,100,25,panel)
	Rem
	?Win32
	panwendicka = CreatePanel(tw-PixmapWidth(pixwendicka),th-PixmapHeight(pixwendicka),PixmapWidth(pixwendicka),PixmapHeight(pixwendicka),panel)
	startgame = CreateButton("Start Game",ClientWidth(panWendicka)-100,ClientHeight(PanWendicka)-25,100,25,panwendicka)
	?
	End Rem
	End Method

	Method flow()
	If Not made build
	startgame.setenabled SelectedGadgetItem(languages)>=0 And TextFieldText(yourname) And ((Not TextFieldText(GameJoltUserName)) Or (TextFieldText(GameJoltUserName) And TextFieldText(GameJoltToken))) And SelectedGadgetItem(Skill)>=0 And ((Not TextFieldText(AnnaId)) Or (TextFieldText(AnnaID) And TextFieldText(AnnaSecu)))
	GameJoltToken.setenabled Trim(TextFieldText(GameJoltUserName))<>""
	SkipGameJolt.setenabled  Trim(TextFieldText(GameJoltUserName))<>"" And Trim(TextFieldText(GameJoltToken))<>""
	AnnaSecu.setenabled      Trim(TextFieldText(Annaid))<>""
	AnnaCreate.setenabled    Trim(TextFieldText(Annaid))="" And Trim(TextFieldText(yourname))<>""
	If EID=event_gadgetaction 
		Select ESource 
			Case StartGame DoStartNewGame
			Case AnnaCreate DoAnnaCreate
			Case AnnaWhatsthis OpenURL "http://utbbs.tbbs.nl/Game.php?A=Read&C=Doc&Doc=Netwerk"
			Case GJWhatsthis OpenURL "http://utbbs.tbbs.nl/Game.php?A=Read&C=Doc&Doc=Netwerk"
			End Select
		EndIf
	End Method
	
	Method toph$(A$)
	Local ret$
	For Local i=0 Until Len(A)
		ret :+ "%"+Right(Hex(a[i]),2)
		Next
	Return ret	
	End Method
	
	Method DoAnnaCreate()
	Local Secu$ = Left(MD5(Rand(0,MilliSecs())),6)
	Local result:StringMap = Anna("&HC=Game&A=BPC_Create&Secu="+Secu+"&name="+Toph(TextFieldText(Yourname)))
	If result.value("REJECT")
		Notify "Anna has rejected your account creation.~n~nThe reason stated is:~n"+result.value("REJECT")
	ElseIf result.value("ID") And result.value("STATUS")="SUCCESS"
		Notify "Anna has accepted your sign up.~nI will now open a browser window for you, so you can verify your account.~nThis is very important as Anna will delete all unverified accounts after 24 hours."
		SetGadgetText Annaid,result.value("ID")
		SetGadgetText annasecu,secu
		OpenURL "http://utbbs.tbbs.nl/Game.php?HC=Game&A=BPC_Verify&id="+result.value("ID")+"&secu="+secu
	Else
		Notify "Unfortunately the creation of the Anna account failed. Possibly something wrong with the site or your internet connection."	
		'Notify result.dump() ' debugline, must be put on 'rem' in release
		EndIf
	End Method

	Method DoStartNewGame()
	Local syscommand$
	Local platform$ 
	Local OpstartFuncties$[] = ["NewGame","NewGamePlus"]
	For Local n$=EachIn ReservedNames
		If Trim(Upper(n)) = Trim(Upper(TextFieldText(YourName))) Return Notify("Cannot launch the game.~nThe word ~q"+n+"~q has been reserved and may therefore not be used as a username.~n~nPlease choose another name!")
		Next
	'Return Notify("Name Accepted!")	 ' Debug line in order not to run the game during testing this out :)
	?MacOS
	platform = "Mac"
	syscommand = "open ~q"+lini.c("Mac")+"~q"
	?Win32
	platform = "Windows"
	syscommand = "~q"+Replace(AppDir,"/","\")+"\"+lini.c("Windows")+"~q"
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
	WriteLine bt,"Var:LoadGame=*NONE*"
	WriteLine bt,"Var:StartScript=Start.lua"
	WriteLine bt,"Var:Title=Star Story"
	WriteLine bt,"Var:User="+TextFieldText(YourName)
	WriteLine bt,"Var:StartUpFunction="+OpstartFuncties[ButtonState(StartNewGamePlus)]
	WriteLine Bt,"Var:CodeName=StarStory"
	WriteLine bt,"Var:Language="+GadgetItemText(languages,SelectedGadgetItem(languages))
	WriteLine bt,"Var:Skill="+Int(SelectedGadgetItem(skill)+1)
	If ButtonState(SkipGameJolt)
	   Select Proceed("WARNING!~n~nAs you can only enter your user name and password now and not when loading a game, skipping a GameJolt login now can result in never being able to login to GameJolt with this playthrough if you made a typo in your username or token.~n~nPlease make sure you entered them correctly!~n~n(And I said TOKEN!!! Not PASSWORD!!!)~n~n(Yes = Start with no login, No = Start with login, Cancel = Don't start!)")
		Case  1 WriteLine bt,"Var:IgnoreGameJolt=Yes"  '+YesNo[ButtonState(IgnoreGameJolt) And (Not Sync)]
		Case  0 Notify "Then I shall just login now!"
		Case -1 Return
		End Select
	   EndIf
	If ButtonState(Windowed) WriteLine BT,"Var:Windowed=Yes"
	If TextFieldText(GameJoltUserName)
		WriteLine bt,"Var:GameJoltUser="+TextFieldText(GameJoltUserName)
		WriteLine bt,"Var:GameJoltToken="+TextFieldText(GameJoltToken)
		EndIf
	If TextFieldText(Annaid)
		WriteLine bt,"Var:AnnaID="+TextFieldText(AnnaID)
		WriteLine bt,"Var:AnnaSecu="+TextFieldText(AnnaSecu)
		EndIf	
	?MacOS
	Local A$ = AppFile
	While ExtractExt(ExtractDir(A)).toupper()<>"APP" a = ExtractDir(A) Wend
	Print "LAURA II will return to "+A+" when finished!"
	WriteLine bt,"Var:MacReturn="+Replace(A," ","\ ")
	?	
	CloseStream BT
	?Not MacOS
	HideGadget window
	?
	'Print "Executing: "+syscommand
	'Notify "Executing: "+syscommand
	Stopmusic	
	system_ syscommand
	?MacOS
	Bye
	?
	?Not MacOS
	ShowGadget Window
	startmusic
	?
	End Method

	End Type
