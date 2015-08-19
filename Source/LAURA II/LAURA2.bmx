Rem
/*
	LAURA II - Lua-based Advanced Utility for Roleplaying and Adventuring - Version II
	As the name suggests, a Lua based interpreter for RPG and adventure games.
	
	
	
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

Rem
One thing to point out.
Yes, it is True that LAURA II is in a GNU license. 
Any source that uses LAURA II or portions of it, 
should therefore be licensed under the GNU license as well
as the license requires.

The games written in LAURA2 (meaning all the stuff that is 
stored in the JCR file called by LAURA2) may have any license
you desire, yes even a close-sourced commercial license.
The fact that the Lua scripts communiticate directly with
the APIs which are part of LAURA2 (And thus of the GNU license)
play no role in that. 

I must thank Yasha of the BlitzMax forums For sorting stuff out
For me in that department:
http://www.gnu.org/licenses/gpl-faq.html#IfInterpreterIsGPL

In a Short clarification in the statment from that site:
= Calling out to the LAURA II apis from Lua does not
  require GNU License.
= Using third party Lua scripts that are GNU licensed
  DOES require GNU license.


If you create a game using LAURA II, you are (of course)
required to give people access to the source code of 
LAURA II itself. In the case you use an unmodified
version, a link to any official download site will do.
If you use a modified version of LAURA II the modified
source must of course be released.


If you want to make sure your game itself cannot be extracted
by everybody by anybody who has the software To analyze Or
extract JCR6 files, remember that JCR6 is Not part of the
LAURA II project, And has therefore its own license (The
Mozilla Public License version 2) And that drivers To make
JCR6 use different storage methods may be in any license you
can think of. If you Create a driver To make your JCR6 files
secure in a separate source file I won't mind if you make
only a call To it from LAURA II without releasing any
source codes. HOWEVER, I strictly do only allow such an action
To go outside the scope of the GNU To write such a driver, Not
To add any extra functionality To LAURA II as an interpreter.

If you have any other reasons to need a close-sourced modified
version of LAURA II, contact me (Jeroen Broks), And If we can
come To an agreement I may provide prior written permission.


====
In order to compile this source code you need the next stuff
= BlitzMax itself (www.blitzmax.com)
= Brucey's Volumes module
= The modules prefixed with "gale", "jcr6" and "tricky_"
  all of them can be downloaded from http://trickymods.tbbs.nl
  Please note, that the download from that site is updated
  as I upgrade these modules, as good as real-time, so I 
  cannot guarantee a stable version. I always try to avoid
  the possibility for "version conflicts", but (too bad) I
  cannot give guarantees.

A few tools you may need if you want to use LAURA II
= JCR6, you can download it on http://jcr5.sourceforge.net
  (please note the 5 in the URL! I couldn't change that name
  anymore, when I moved from JCR5 to JCR6). 
= Kthura Map Editor. It was not yet released when I wrote
  this notice, it very likely will be over time.

This line contains security material and is therefore not given away. The engine
should compile without it. In the case of Star Story this will mean that the
game will not work with the "GameJolt.net" file present. Removing or renaming
it and the game will work as it should, however it will be unable to contact
GameJolt, that's all. :)

====
Another note. In some of the included files (most notably the sources of the 
imported GALE modules, and the files in the inc/api/ folder) will contains
comments starting with "BLD: ". These are tags an automated .html generator
called BLD responds to create a command overview 
End Rem

' Import the required APIs from the gale framework
Framework	gale.m2d
Import	gale.multiscript
Import	gale.shell
Import	gale.gamevar
Import	gale.image
Import	gale.jcr6api
Import	gale.strings
Import	GALE.Mathemethics
Import	gale.m2dinput
Import	gale.luaaudio
Import	gale.Time
Import	gale.luablopplasma
Import	gale.dirgetter

' Import the KThura map engine
Import	tricky_kthura.kthura_draw

' Import the required JCR6 drivers
Import	jcr6.zlibdriver
Import	jcr6.quakepak ' Yes, I decided to support the Quake Pack files as well, in case you prefer that above JCR6. Please note that Quake Pack files are less sophisticated than JCR6 files, this can influence the support. Keep that in mind!

' JCR6 raw file support, needed for some internal scripts. (and the temp scripts)
Import	jcr6.fileasjcr

' Import some general units by tricky
Import	tricky_units.initfile
Import	tricky_units.identify
Import	tricky_units.Dirry ' Please note that the inclusion of this module requires to have the bah.volumes module by Brucey to be installed as well.
Import	tricky_units.Bye
Import	tricky_units.HotSpot
Import      tricky_units.specialchars
Import      tricky_units.RPGStats
Import      tricky_units.SafeString
Import	tricky_units.Append
Import	tricky_units.advdatetime


' Lastly some brl modules I really need
Import	brl.pngloader
Import	brl.oggloader
Import	brl.freeaudioaudio
Import	brl.glmax2d
Import	brl.freetypefont



' Version
MKL_Lic     "LAURA II - LAURA2.bmx","GNU - General Public License ver3"
MKL_Version "LAURA II - LAURA2.bmx","15.06.27"

' Basic Includes
Include	"inc/globals.bmx"
Include	"inc/KthuraErrorReplacements.bmx"
Include	"inc/startupfile.bmx"
Include	"inc/error.bmx"
Include	"inc/Loading.bmx"
Include     "Inc/Init.bmx"
Include     "Inc/Flow.bmx"
Include     "inc/Savegame.bmx"
Include     "inc/Swap.bmx"

' Lua Api includes
Incbin 	"inc/api/EmptyMapScript.lua"
Include     "inc/api/Maps.bmx"
Include 	"inc/api/Actors.bmx"
Include	"inc/api/LAURA.bmx"
Include     "inc/api/Effects.bmx"

StartUpFile ' Must be called BEFORE the games goes into graphics mode as it's also possible we are only informing about the version.
Init
RunFlow
