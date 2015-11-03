Rem
	LAURA II
	Security framework
	
	
	
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
Version: 15.11.03
End Rem
Strict
Import tricky_units.initfile
Import brl.linkedlist
Import jcr6.jcr6main
Import tricky_units.gamevars
Import tricky_units.rpgstats
Import tricky_units.console
Type TSecu
	
	Method New() ListAddLast SecuList,Self End Method	
	Method Check(JCR:TJCRDir,d:TIni) Abstract	
	Method SSecuInit() Abstract
	Method SSecu(e$,d$) Abstract
	Method SSecuDone(J:TJCRCreate) Abstract
	Method LSecu(J:TJCRDir,MainJ:TJCRDir) Abstract	
	End Type

Type TNetwork
	Method Login(d:TIni) Abstract
	Method Name$() Abstract
	Method User$(d:TIni) Abstract
	Method SaveLogin(bt:TJCRCreate,d:TIni) Abstract
	Method LoadLogin(J:TJCRDir,d:TIni) Abstract
	Method New() ListAddLast NetList,Self End Method
	End Type


Global SecuList:TList = New TList
Global NetList:TList = New TList


Function SSecuInit()
For Local S:TSecu = EachIn seculist S.SSecuInit; Next
End Function

Function SSecu(e$,d$) 
For Local S:TSecu = EachIn seculist S.SSecu e,d; Next
End Function

Function SSecuDone(J:TJCRCreate)
For Local S:TSecu = EachIn seculist S.SSecuDone J; Next
End Function


Function SecuStrMap$(d:StringMap)
Local r$=""
For Local K$=EachIn MapKeys(D)
	r$ = k$+" = "+d.value(k)+"~n"
	Next
Return r
End Function

Function SSecuStringMap(e$,D:StringMap)
Local r$ = secuStrMap(d)
ssecu e,r
End Function

Function SaveNet(bt:TJCRCreate,d:TIni)
For Local N:TNetwork=EachIn NetList
	ConsoleWrite "Saving login data: "+N.Name(),255,95,10
	N.SaveLogin bt,d
	Next
End Function

Function LoadNet(bt:TJCRDir,d:TIni)
For Local N:TNetwork=EachIn NetList
	ConsoleWrite "Loading login data: "+N.Name(),255,95,10
	N.LoadLogin bt,d
	Next
End Function


Function SecuFile(file$)
SSecuInit()
Local JI:TJCRDir = JCR_Dir(file$)
Local JO:TJCRCreate = JCR_Create(file+"_$$$$_SECU_$$$$_")
Local data$
For Local F$=EachIn EntryList(JI)
	data = LoadString(JCR_B(JI,f))
	ssecu f,data
	JO.addstring data,JI.EntryData(f).FileName,"zlib"
	Next
ssecudone JO
JO.Close
DeleteFile file
RenameFile file+"_$$$$_SECU_$$$$_",file
End Function	

Function LSecu(J:TJCRDir,MainJ:TJCRDir)
Local Original = True
For Local S:TSecu = EachIn seculist
	Original = Original And S.LSecu(J,MainJ)
	Next
Return Original
End Function
