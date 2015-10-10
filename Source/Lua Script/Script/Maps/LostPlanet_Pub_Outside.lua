--[[
**********************************************
  
  LostPlanet_Pub_Outside.lua
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
 
version: 15.10.08
]]


function IntroBar()
if not Done("&DONE.MAP.INTROBAR") then
   PartyPop("Bar")
   MapText("INTROBAR")
   PartyUnPop()
   end
end

function BoxTextBackGround() -- Used for Rickrolling
rickrollcounter = (rickrollcounter or 0) + 1
if rickrollcounter>50 then Maps.Obj.Obj("BANNER_RICKROLLED").Visible = boolbt[Maps.Obj.Obj("BANNER_RICKROLLED").Visible~=1] rickrollcounter=0 end
Maps.Remap() 
Image.Cls()
Maps.Draw()
end

function NPC_RICKROLL()
local a = GetActive()
if a~="Wendicka" and a~="Crystal" and a~="Foxy" then MapText("RICKSILENT") return end
MapText("RICKROLL.1")
CharMapText("RICKROLL.2")
MapText("RICKROLL.3")
BoxTextBack = "MAP"
Music("Scenario/RICKROLLED.ogg")
MapText("RICKROLL.4","MAP")
BoxTextBack = "BOXTEXT.KTHURA"
Music("Sys/Silence.ogg")
Maps.Obj.Obj("BANNER_RICKROLLED").Visible = 0
Maps.Remap()
CharMapText("RICKROLL.5")
Music("Scenario/Dream Culture.ogg")
if not Done("&RICKROLLED") then
   MapEXP()
   Award("RICKROLLED")
   end
end

function NPC_PoepAurina()
if not Done("&DONE.TALK.POEP.AURINA") then MapText("POEP") end
if CVV("%AURINAS")==0 then MapText("POEPGEENAURINA") return end
Var.D("%AURINARATE",CVVN("%AURINARATE") or (5-skill))
local aurina = CVV("%AURINAS")
local rate = CVV("%AURINARATE")
local total = aurina * rate
Var.D("%AURINACREDITS",total)
MapText("POEPAURINA")
inc("%CASH",total)
Var.Clear("%AURINAS")
end

function NPC_Merchant()
MapText("MERCHANT")
-- MINI("Stores are not yet present")
GoToStore("LOSTPLANET_BAR_ITEMS")
end

function Exit()
LoadMap("LostPlanet_GrassJungle_3")
SpawnPlayer("Einde")
TurnPlayer("South")
end

function CLICK_ARRIVAL_EnterPub()
	if CVV("&DONE.YIRLJOIN") then
		MapText("NO_ENTER")
	else
		LoadMap("LOSTPLANET_BARINSIDE")
		SpawnPlayer("Entrance")
	end	
end


function GALE_OnLoad()
Music("Scenario/Dream Culture.ogg")
SetScrollBoundaries(1,1,1,384)
-- Zone Action
ZA_Enter("IntroBar",IntroBar)
ZA_Enter("Exit",Exit)
-- Hide the "Rickrolled" banner.
Maps.Obj.Obj("BANNER_RICKROLLED").Visible=0
Maps.Remap()
end
