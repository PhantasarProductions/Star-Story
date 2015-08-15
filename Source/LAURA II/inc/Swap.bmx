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
Return df(File)
End Function
