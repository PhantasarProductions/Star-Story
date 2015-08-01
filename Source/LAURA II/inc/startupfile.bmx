Rem
/*
	LAURA II - Lua-based Advanced Utility for Role-Play and Adventuring
	This is a quick file to start things up.
	
	
	
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


Version: 15.08.01

End Rem
Incbin "Witch.png"

Function StartUpFile()
Local suf$ = Dirry(sstartupfile)
Local ovf$ = Dirry(AppSupportdir)+"VersionDump.txt"
Local ov$
Local codename$
startup = LoadIni(suf)
If Not startup error suf+" could not be found!~n~nMost LAURA II games come with a launcher. Make sure you run the game through that launcher and not by directly calling LAURA II"
codename = startup.C("CodeName"); If Not codename Error "No CodeName for the game! Is the laucher data setup correctly?"
AppTitle = Startup.C("Title")
ov =  "LAURA II - Coded by Tricky~n"
ov :+ "(c) Jeroen P. Broks 2015~n"
ov :+ "Released under the terms of the GNU General Public License version 3~n~n"
ov :+ "Version: "+MKL_NewestVersion()+"~n~n"+MKL_GetAllversions()+"~n~n"
Print ov
' Dump version data if we only need the version
If StartUp.C("VersionOnly")
	Print "Outputting versions to "+ovf
	SaveString ov,ovf
	Bye
	EndIf
' LAURA logo
Local Witch:TImage = LoadImage("incbin::Witch.png")
AppTitle = "LAURA is initiating"
If Not Witch
	Graphics 300,300
	Else
	Graphics ImageWidth(Witch),ImageHeight(Witch)
	DrawImage Witch,0,0
	Flip
	EndIf
AppTitle = "LAURA II"
' Patch up JCR files	
If Not startup.List("Resource") error "LAURA II does not know which resources it needs to call.~nMake sure that this is properly defined in the startup file"
For Local R$=EachIn startup.list("Resource")
	Print "Adding resource file: "+R
	JCR_AddPatch JCR,R
	Next
' set console background
If JCR_Exists(JCR,"GFX/System/Console.png") ConsoleBackGroundPicture = LoadImage(JCR_B(JCR,"GFX/System/Console.png"))
' Required JCR references
JCR_Lua_Image_PatchMap = JCR	
AudioJCR = jcr
GALEMSJCR = jcr
GALEAPIJCRDIR = jcr
' Tempdir
JCR_EDir = Dirry(AppSupportdir+"/"+codename+"/JCR_E")
CreateDir JCR_EDir,2
' Savedir
SaveDir = Dirry(AppSupportdir+"/"+codename+"/Saved Games")
CreateDir SaveDir,2
' A few default variable definitions
Local s = startup.C("Skill").ToInt()
If Not s s = 2
VarDef("%SKILL",s)
Local L$ = startup.C("Language")
If Not L L="English"
VarDef("$LANG",L)
End Function


MKL_Version "LAURA II - inc/startupfile.bmx","15.08.01"
MKL_Lic     "LAURA II - inc/startupfile.bmx","GNU - General Public License ver3"
