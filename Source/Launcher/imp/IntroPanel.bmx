Rem
	Launcher - Star Story
	Intro panel
	
	
	
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
Import tricky_units.HotSpot
Import "Framework.bmx"

JCR6CrashError = True

Type TFadeFrame
	Field y:Double
	Field scale:Double = 1
	Field color:Double = 1
	Field frame
	End Type

Type introaction Extends TFPanelBase

	Field P:TPixmap = LoadPixmap(JCR_B(JCR,"GFX/Intro/Introtext.png"))
	Field IntroText:TImage = LoadAnimImage(P,PixmapWidth(P),1,0,PixmapHeight(P))	
	Field stars:TImage = LoadImage(JCR_B(JCR,"GFX/Intro/Starfield.png"))
	Field StarStory:TImage = LoadImage(JCR_B(JCR,"GFX/Intro/StarStory.png"))
	Field Phantasar:TImage = LoadImage(JCR_B(JCR,"GFX/Intro/PhantasarProductions.png"))
	
	Field sqimg:TImage[]
	Field alpha:Double=3
	
	Field tabset
	
	Field process = 1
	Field ITL:TList = MakeFade()
	
	
	Method MakeFade:TList()
	Local F:TFadeFrame
	Local y=800
	Local ret:TList = New TList
	sqimg = [Phantasar,phantasar,StarStory]
	If Not phantasar Notify "Phantasar Logo not properly loaded" Bye
	If Not starstory Notify "StarStory Logo not properly loaded" Bye
	For Local I:TImage = EachIn sqimg 
		Print "Hotcentering Logo"
		If Not I Notify "One of the logos has not been properly loaded!" Bye
		HotCenter i 
		Next
	If Not introtext
		Notify "Could not properly set up the introtext"
		Bye
		EndIf
	HotCenter introtext
	For Local ak=0 Until PixmapHeight(P)
		y:+1
		F = New TFadeFrame
		F.y = y
		f.frame = ak
		ListAddLast ret,f
		Next	
	Print "MakeFade done"
	Return ret		
	End Method
	
	Method flow()
	Local done3
	'Print "allow = "+allowcanvas+"; no = "+nocanvas
	If Not allowcanvas Return
	If nocanvas Return
	'Self.panel = introcanvas
	SetGraphics CanvasGraphics(introcanvas)
	'If CanvasGraphics(Self.panel) Print "Canvas" Else Print "NoCanvas"
	If Not CanvasGraphics(introcanvas) Return
	SetBlend alphablend
	Cls
	SetColor 255,255,255
	SetAlpha 1
	SetScale 1,1
	TileImage stars,0,0
	Select process
		Case 1,2
			If alpha>1 SetAlpha 1 Else SetAlpha alpha
			DrawImage sqimg[process],tw/2,th/2
			alpha:-.005
			If alpha<0
				alpha=3
				process:+1
				EndIf
		Case 3		
			done3=True	
			For Local f:TFadeFrame = EachIn ITL
				SetScale f.scale,f.scale
				SetColor 255*f.color,180*f.color,0
				DrawImage introtext,tw/2,f.y,f.frame
				f.y:-f.scale
				If f.y<TH
					If f.scale>0 f.scale:-.001
					If f.color>0 f.color:-.0005
					EndIf
				done3 = done3 And f.scale<=0	
				Next
			If done3 process=1
		Case 4
			DrawImage starstory,tw/2,th/2		
		End Select
	Flip
	Rem
	If Not tabset ' Should put the launcher to the last used tab, but only on the first cycle.
		PollEvent
		MGIF_GetConfig Config
		tabset = True
		EndIf
	End Rem	
	End Method
	
	End Type

Global introcanvas:TGadget = CreateCanvas(0,0,tw,th,tabber)
If Not introcanvas Print "Warning! Introcanvas not properly created!"

addxpanel "Intro",New IntroAction,introcanvas
