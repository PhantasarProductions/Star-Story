Rem
	LAURA II
	Swar dir manager
	
	
	
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
Version: 16.02.06
End Rem

MKL_Version "LAURA II - Swap.bmx","16.02.06"
MKL_Lic     "LAURA II - Swap.bmx","GNU General Public License 3"

Function CreateSwapDir(dir$="")
Local pd$ = dir
If Not Prefixed(dir,swapdir) 
	pd = swapdir+"/"+pd
	If Not dir pd = swapdir
	EndIf
If Not CreateDir(dir,1) GALE_Error "Swap folder could not be created",["Folder,"+dir]
SaveString "######## ######## WARNING ######## ######## WARNING ######## ########~nThis folder must solely be used by a LAURA II game to store swap data~nAny other use is strictly discouraged as the data in this entire folder is entirely deleted each time LAURA II is launched!~n~nThe creator of LAURA II or of the respective game running in LAURA II cannot be held responsible for any loss of data caused by wrong usage of this folder!~n~n######## ######## WARNING ######## ######## WARNING ######## ########",pd+"/WARNING! README FIRST.TXT"
End Function

Function SwapAbuse:TStream(F$)
GALE_Error "Swap abuse",["File,"+F]
End Function

Function LWriteFile:TStream(F$)
Return WriteFile(F)
End Function

Function WriteOrAppend:TStream(File$)
Local af:TStream(F$)[] = [LWriteFile,AppendFile,SwapAbuse]
Local df:TStream(f$) = af[FileType(File)]
Local as$[] = ["Creating file: "+File,"Appending to file: "+File,"Hey, this is no file: "+File]
ConsoleWrite as[FileType(file)],180,255,0
Return df(File)
End Function
