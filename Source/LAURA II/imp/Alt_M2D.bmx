Rem

	(c)  Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.


Version: 15.07.12

End Rem
Strict
Rem

		This is only a copied and adapted version of the M2D driver of GALE.
		I was dealing with some trouble GALE didn't want to get around, so
		I had to resort to the "dirty" method here.
		
		This file will cover a few things to be done specific to LAURA II.
		
		The license of this file will remain in the MPL 2.0 despite the rest of 
		LAURA II being licensed under the terms of the GNU GPL
		
End Rem		
	

' 14.06.04 - Initial version
' 15.01.23 - Updated for the JCR6 version of GALE





' Importing required modules
Import Brl.Max2d
'Import Brl.MaxLua
Import GALE.MaxLua4Gale

' Importing GALE imports you really should have
' Import "GALE_Sys.bmx" ' No longer needed as the contents are merged into this file as of 13.12.26

' Importing the JCR5 reader 
'Import Tricky.JCR5
' Import "../JCR5/JCR_Read.bmx" ' Old JCR reader, before it became a module

' Importing the required "Units"
Import Tricky_units.console
'Import "../Units/MKL_Version.bmx" ' MKL_Version has been transformed into a module for better access from other modules of mine.
Import Tricky_Units.MKL_Version
Import tricky_units.Bye

Import Gale.Main



' I moved this here.
Global SessionFile$ ' Part of LAURA II, very important 
Global SessionLogFile$  ' Part of LAURA II, very important too
Global SessionLogStream:TStream ' Part of LAURA II development mode, very important too.
Global ErrorClosureMessage$


' Versions
MKL_Version "GALE - GALE_M2D.bmx","15.07.12"
MKL_Lic     "GALE - GALE_M2D.bmx","Mozilla Public License 2.0"





'This is just some shit the BLD utilty (which I use to set up a quick documentation) needs for documenting the Lua directives created by this program
'Directive USE <FILE>				' BLD: This directive makes you add a script to this script.<br>Note: It does not include on the spot, the new file will be added below the current script file<br>Note: Files are added in the order in which they are called.<br>Note: When you don't enter a path the preprocessor will either use the same path as the main file or the path set in the project the Lua processor has been included to. If you are picky about your paths, set it well!
'Directive IF &lt;DEF1> [&lt;DEF2>...]	' BLD: Is a definition set, then compile the next stuff, if not, ignore it. When you put a "!" before a definition it will count as a 'NOT' statement.<br>NOTE:You cannot make an IF in an IF. If not done before, this IF will automatically close the IF statement made before.
'Directive ELSEIF &lt;DEF1> [&lt;DEF2>...]	' BLD: Works with IF as an ELSEIF. Some bugs I cannot trace well make this directive irreliable so I recommend not to use it until I got that fixed.
'Directive FI						' BLD: Ends an IF statement made before
'Directive ENDIF  					' BLD: Alias for FI
'Directive DEFINE &lt;DEF>			' BLD: Set a defition for IF/ELSEIF/FI to use.
'Directive UNDEF &lt;DEF>			' BLD: Unset a definition for IF/ELSEIF/FI. It also undoes DEFINE
'Directive USEDIR &lt;DIR> 			' BLD: In JCR based projects, this directive can include all .lua files in a directory within the JCR patchlist and it works recursive.
'Directive SELECT &lt;var/function>	' BLD: You can use this directive to create a "SELECT" statement (same as "switch" in C-syntax languages). As Lua doesn't support that itself I made this preprocessor do it.<br>You cannot place a remark behind this statement or the preprocessor will create faulty Lua scripts. If you want a remark with this, put it either above or below it :)<br>NOTE: Only one SELECT can be open at a time. When you open a new one, the old one will be closed, however keep closing your SELECT statements anyway, as you never know if I might improve this in the future :)
'Directive CASE &lt;value>			' BLD: Case command for @SELECT
'Directive DEFAULT 				' BLD: Default command for @SELECT
'Directive ENDSELECT 				' BLD: Closes Select statement
'Info GALE_ prefix ' BLD: This prefix is reserved for any features that GALE may react on or assign data to. So only use GALE_ prefixed stuff in accordance with this manual. When more functions are added in the future this prefix is very likely to be put in front of it. Some projects using GALE might also use their own prefixes (for example the LAURA engine uses "__" as reserved prefix), so check the data on that.
'Info GALE_OnLoad() function ' BLD: When this function is present anywhere in the script GALE will automatically execute it after compiling
'Info GALE_OnUnload() function ' BLD: When this function is present anywhere in the script GALE will automatically execute it when the script is removed from the memory. Please note that the BlitzMax garbage collector is responsible for this, and you never know when the garbage collector cleans up the memory as that is when the function will be called.
'Info Preset Definitions			' BLD: The next definitions can not be set/unset with DEFINE or UNDEF, but IF and ELSEIF can see them and they can be used there.<p><table><tr><td>$WINDOWS</td><td>Set if running from Windows</td></tr><tr><td>$MAC</td><td>Set if running from MacOS X</td></tr><tr><td>$MACOS</td><td>Alias for $MAC</td></tr><tr><td>$LINUX</td><td>Set if running from Linux</td></tr><tr><td>$DEBUGBUILD</td><td>Set if you happen to use the debug build of the engine</td><tr><td>$RELEASEBUILD</td><td>Set if you use the release build of your engine</td><tr><td>$LITTLEENDIAN</td><td>Set if processor uses LittleEndian</td><tr><td>$BIGENDIAN</td><td>Set if your processor uses BigEndian</td></tr><tr><td>$X86</td><td>Set if you have use and X86 processor (Intel or compatible)</td></tr><tr><td>$PPC</td><td>Set if you use a PowerPC processor</td></tr></table>


' This has now been put into a separate file in order to make it easier for the MaxGUI version of GALE to work as much with the same routines as possible.
'Include "INC_MAINGALE.BMX"




' The functione below make contact with Max2D. In the GUI version they put it on a by a user selected textfield.
'Private

Type GALEMainCon2 Extends GALE_DebugConsole 'GALE_DebugConsole
	Method GaleConsoleWrite(Txt$,R=255,G=255,B=255)
	ConsoleWrite(Txt,R,G,B)
	End Method

	Method GaleConsoleShow()
	ConsoleShow
	End Method

	Method GaleConsoleDoublePrint2(Txt1$,Txt2$,T,R1=255,G1=255,B1=255,R2=255,G2=255,B2=255)
	ConsoleDoublePrint2 txt1,txt2,t,r1,g1,b1,r2,g2,b2
	End Method

	Method GaleConsoleCloseLogFile()
	ConsoleCloseLogFile
	End Method
	
	Method GaleErrorClosureRequest()	
	Local gotlog = FileType(SessionLogFile)<>0
	Local cont$[] = ["Hit any key to continue","Do you wish to open the log in the browser? (Y/N)"]
	ConsoleCloseLogFile()
	For Local line$=EachIn ErrorClosureMessage.Split("\n")
		ConsoleWrite line,255,180,0
		Next
	GALEConsoleWrite "Hit any key to coninue",255,0,255
	Graphics 800,600,0
	FlushKeys
	Cls
	ConsoleShow
	Flip
	If Chr(WaitKey())="Y" And gotlog OpenURL SessionLogFile
	Bye
	End Method
	
	Method DoFlip(A=-1)
	Flip
	End Method

	Method DoCls()
	Cls
	End Method
	
	Method Rewindow()
	Local GW = GraphicsWidth()
	Local GH = GraphicsHeight()
	EndGraphics
	Graphics GW,GH
	End Method	
	
	Method StopGraphics()
	EndGraphics
	End Method
	
	Method RequestAppTerminate()
	Return AppTerminate()
	End Method
	
	Method FullView()
	SetViewport 0,0,GraphicsWidth(),GraphicsHeight()
	SetOrigin 0,0
	End Method
	
	End Type

Public
GaleCon = New GALEMainCon2
Private




Type LConsole ' BLD: Object Console\nAllows a lua script to write something on the (debug) console

	
	Method Write(Txt$,R=255,G=255,B=255) ' BLD: Writes something onto the console in the desired color
	ConsoleWrite Txt,R,G,B
	End Method

	Method Print(Txt$,R=255,G=255,B=255) ' BLD: Alias for Console.Write
	ConsoleWrite Txt,R,G,B
	End Method
	
	Method Show() ' BLD: Show the console the way it looks now (you'll require to do a FLIP, to make it actually appear on the physical screen) :)
	ConsoleShow
	End Method
	
	Method Flip() ' BLD: Same as Image.Flip, but included here just in case the Image object wasn't used in the particular project ;)
	'DebugLog "Flipping in Console object"
	brl.Graphics.Flip
	End Method
	
	End Type
	
GALE_Register New LConsole,"Console"
