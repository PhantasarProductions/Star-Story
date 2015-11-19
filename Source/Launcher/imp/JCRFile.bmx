Rem
	Launcher - Star Story
	JCR6 routines
	
	
	
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
Version: 15.11.19
End Rem
Strict
Import "jcr6crash.bmx"
Import jcr6.zlibdriver
Import "launcherini.bmx"

JCR6CrashError = True

?Not MacOS
Global JCR:TJCRDir = JCR_Dir(LIni.C("Resource"))
?MacOS
Global JCR:TJCRDir = JCR_Dir(LIni.C("LauncherResourceDir")+LIni.C("Resource"))
?
If Not LIni 
	Notify "ERROR!~n"+LIni.C("Resource")+" could not be read"
	Bye
	EndIf
	 

