--[[
**********************************************
  
  Reggie.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 15.10.20
]]
-- @IF IGNOREME
SpellAni = {}
-- @FI

function ShowReggie()
	Image.LoadNew("REGGIE","GFX/Portret/Reggie/General.png")
	Image.HotCenter("REGGIE")
	local dirs = { {900,300,-4,0} , {400,700,0,-4} , {400,-200,0,4} }
	local dir = dirs[rand(1,#dirs)]
	if dir[1]~=400 then
		for ix = dir[1],400,dir[3] do
			DrawScreen()
			Image.Show("REGGIE",ix,iy)
			Flip()
		end
	else
		for iy = dir[2],300,dir[4] do
			DrawScreen()
			Image.Show("REGGIE",ix,iy)
			Flip()
		end
	end
	for ialpha=100,0,-1 do
		Image.SetAlphaPC(100)
		DrawScreen()
		Image.SetAlphaPC(ialpha)
		Image.Show("REGGIE",300,400)
	end
	Image.SetAlphaPC(100)
end


function SpellAni.ReggieBurn(ActG,ActT,TarG,TarT)
	ShowReggie()
	SpellAni.Burn(ActG,ActT,TarG,TarT)
end

function SpellAni.ReggieBurnAll(ActG,ActT,TarG,TarT)
	ShowReggie()
	SpellAni.BurnAll(ActG,ActT,TarG,TarT)
end

function SpellAni.ReggieInferno(ActG,ActT,TarG,TarT)
	ShowReggie()
	SpellAni.Inferno()
end
