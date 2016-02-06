Rem
	LAURA II
	Loading screen
	
	
	
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
Function InitLoading()
LoadingImg = LoadImage(JCR_B(JCR,"GFX/Loading/Graphic.png"))
If Not loadingimg error "GFX/Loading/Graphic.png does not appear to be present in the game's resource file!"

Select id.get("LoadingPosition").toupper()
	Case "BOTTOMRIGHT"
		loadingX = GraphicsWidth()
		loadingY = GraphicsHeight()
		HotSpot Loadingimg,1,1
	Default
		loadingx = GraphicsWidth()/2
		loadingy = GraphicsHeight()/2
		HotCenter loadingimg
	End Select
End Function

Function Loading()
Cls
DrawImage loadingimg,loadingx,loadingy
Flip
End Function
