Rem
	Launcher - Star Story
	JCR6 routines
	
	
	
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
Version: 16.01.27
End Rem
Strict
Import "jcr6crash.bmx"
Import jcr6.zlibdriver
Import "launcherini.bmx"

MKL_Version "LAURA II - JCRFile.bmx","16.01.27"
MKL_Lic     "LAURA II - JCRFile.bmx","GNU General Public License 3"

JCR6CrashError = True

If Not LIni 
	Notify "ERROR!~n"+LIni.C("Resource")+" could not be read"
	Bye
	EndIf


?Not MacOS
Global JCR:TJCRDir = JCR_Dir(LIni.C("Resource"))
?MacOS
Global JCR:TJCRDir = JCR_Dir(LIni.C("LauncherResourceDir")+LIni.C("Resource"))
?
	 


Private
Global FullVersionFound = False
AppTitle = "Star Story Launcher"
For Local F:TJCREntry=EachIn MapValues(JCR.Entries)
	fullversionfound = fullversionfound Or Upper(StripDir(F.MainFile))="STARSTORY_FULLGAME.JCR"
	Next
If Not fullversionFound Then Notify "Welcome to the demo of Star Story.~n~nPlease note that this game is still a work in progress.~nDue to that you can only play part of the game and some features, items and spells do not yet work properly.~n~nYou may play the game to get a global impression of things as they are now.~n~nIf you find a bug in here and you think I don't know about it, please visit my issue tracker at: ~nhttps://github.com/Tricky1975/Star-Story/issues"
