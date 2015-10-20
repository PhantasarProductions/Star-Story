--[[
  Burn.lua
  Version: 15.10.20
  Copyright (C) 2015 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]

-- @IF IGNOREME
SpellAni = {}
-- @FI

function Load_SAP_Flame()	
	if Image.Exist("SAP_Flame")==0 then
		SAP_Flame = Image.LoadAnim('GFX/Combat/SpellAni/Flame/Flame.png',70,140,0,10)
		Image.Assign(SAP_Flame,"SAP_Flame")
		Image.Hot('SAP_Flame',Image.Width('SAP_Flame')/2,Image.Height('SAP_Flame'))
	end
	SAP_Flame = 'SAP_Flame'   	
end


function SpellAni.Burn(ActG,ActT,TarG,TarT)
	local x,y = FighterCoords(TarG,TarT)
	Load_SAP_Flame()
	SFX('Audio/SFX/SpellAni/Fire.ogg')
	for ak=0,9 do
		DrawScreen()
		Image.Draw(SAP_Flame,x,y,ak)
		Flip()
		Time.Sleep(150)
	end 	
end

function SpellAni.BurnAll(ActG,ActT,TarG,TarT)
	local x,y
	local tlist = {}
	local t
	-- @SELECT TarG
	-- @CASE "Hero"
	for ak=1,4 do
		x,y = FighterCoords(TarG,ak)
		if RPGStat.PartyTag(ak)~="" and RPGStat.Points(RPGStat.PartyTag(ak),"HP")>0 then table.insert(tlist,{x=x,y=y}) end
	end
	-- @CASE "Foe"
	for ak=1,9 do
		x,y = FighterCoords(TarG,ak)
		if Fighters.Foe[ak] and RPGStat.Points(Fighters.Foe[ak].Tag,"HP")>0 then table.insert(tlist,{x=x,y=y}) end
	end       
	-- @ENDSELECT       
	Load_SAP_Flame()
	SFX('Audi/SFX/SpellAni/Fire.ogg')	
	for ak=0,9 do
		DrawScreen()
		for t in each(tlist) do
			Image.Draw(SAP_Flame,t.x,t.y,ak)
		end
		Flip()
	end
	Time.Sleep(75)
end 

function SpellAni.Inferno()
	Load_SAP_Flame()
	local c,x,y
	local screen=Image.GrabScreen()
	local fl = {}
	local f
	local scaler
	for c=255,0,-2 do
		Image.Color(255,c,c)
		Image.Draw(screen)
		Flip()
	end 
	if SolarFire then
		CSay("Solar Fire!")
		for scaler=0,100,1 do
			CSay("  scaler = "..scaler)
			Image.Color(255,0,0)
			Image.Draw(screen)
			Image.Color(255,255,255)
			Image.ScalePC(100,scaler) 
			Image.Draw(SolarFire,0,600)
			Image.ScalePC(100,100)
			Flip()  
		end
		Time.Sleep(100)        
	end    
	CSay("Creating Flames")   
	for y = 10,600,10 do
		for x=1,5 do table.insert(fl,{x=rand(0,800),y=y}) end
	end
	SFX('Audio/SFX/SpellAni/Fire.ogg')    
	for ak=0,9 do
		CSay("Flame frame: "..ak)
		Image.Color(255,0,0)
		Image.Draw(screen)
		Image.Color(255,255,255)
		for _,f in ipairs(fl) do
			Image.Draw(SAP_Flame,f.x,f.y,ak) 
		end
		Time.Sleep(75)    
		Flip()        
	end
	Image.Free(screen)        
end

