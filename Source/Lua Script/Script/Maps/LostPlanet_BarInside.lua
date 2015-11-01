--[[
**********************************************
  
  LostPlanet_BarInside.lua
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
 
version: 15.11.01
]]


function Astrilopups()
	if GetActive()=="Wendicka" then
		MapText("ASTRILO_WENDICKA")
	else
		MapText("ASTRILO_OWN")
		CharMapText("ASTRILO_NOTUNDERSTAND")
	end	
end

function Fight()
	local FightPics = {}
	for i=1,5 do 
		FightPics[i] = Image.Load("GFX/Scenario/Fight/"..i..".png") 
		Image.HotCenter(FightPics[i])
	end	
	local FightTable = {}
	for alpha=-200,100 do
		DrawScreen()
		White()
		if #FightTable==0 or rand(1,10)==1 then FightTable[#FightTable+1] = { x=rand(30,770), y = rand(30,570), pic=rand(1,5) } end
		if rand(1,50)==1 then table.remove(FightTable,1) end
		for f in each(FightTable) do Image.Show(FightPics[f.pic],f.x,f.y) end
		if alpha>0 then
			Black()
			Image.SetAlphaPC(alpha)
			Image.Rect(0,0,800,600)
		end
		Flip()
	end	
	for i=1,5 do Image.Free(FightPics[i]) end
end

	

NPC_Astrilopup1 = Astrilopups
NPC_Astrilopup2 = Astrilopups

function NPC_Yirl()
	if not CVV("&DONE.STORK") then
		MapText("YIRL_NOGO")
		return
	end
	PartyPop("Yirl")
	MapText("YIRL")
	Fight()
	Party("Wendicka","Crystal","ExHuRU","Yirl","Foxy")
	LoadMap("LostPlanet_Dungeon_Cell")
	Maps.Obj.Obj("KijkGat").X = -32
	Maps.Obj.Obj("KijkGat").Y = 0
	SpawnPlayer("Start")
	SetActive("Wendicka")
	Actors.ChoosePic("PLAYER","WENDICKA.SOUTH")
	MapText("CAPTURED")
	for i=0,100 do
		Maps.Obj.Obj("KijkGat").Alpha = Maps.Obj.Obj("KijkGat").Alpha - 0.01
		Maps.Draw()
		Flip()
	end
	Maps.Obj.Obj("KijkGat").Visible = 0
	Maps.PermaWrite('Maps.Obj.Obj("KijkGat").Visible=0')
	for ak=2,6 do
		MapText("CAPTURED_"..ak)
		if ak~=6 then KickReggie(({"West","East"})[rand(1,2)],'Foxy','Reggie') end
	end
	Done("&DONE.YIRLJOIN")
	for c in each({"Crystal","ExHuRU","Yirl","Foxy"}) do Maps.Obj.Kill(c,1) end
	Actors.Actor("PLAYER").y = Actors.Actor("PLAYER").y - 32
	Maps.Remap()
end

function ByeBye()
	LoadMap("LostPlanet_Pub_Outside")
	SpawnPlayer("SPOT_EnterPub")
	TurnPlayer("South")
end

function NPC_Stork()
	if Done("&DONE.STORK") then
		MapText("STORK_AGAIN")
	else
		PartyPop("Stork")
		MapText("STORK")
		PartyUnPop()
	end
end

function NPC_Bladeh()
	if GetActive()=="Wendicka" then
		MapText("ALIEN_WENDICKA")
	else
		MapText("ALIEN")
	end
end



function GALE_OnLoad()
	Music("Location_Pub_Jungle/1 - TDCi - Don't Talk Too Much.ogg")
	SetScrollBoundaries(0,0,0,0)
	ZA_Enter("Exit",ByeBye)	
end
