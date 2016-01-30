--[[
**********************************************
  
  LostPlanet_Junkyard.lua
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
 
version: 15.10.31
]]


function Next()
local x,y = GetCoords()
Actors.StopMoving('PLAYER')
Actors.MoveTo('PLAYER',x,-64,1)
WalkWait()
local c = Sys.Val(right(Maps.LayerCodeName,3))
c = c + 1
local lay = "#"..right("00"..c,3)
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer(lay)
SpawnPlayer("Start")
TurnPlayer("North")
end

function Prev()
local x,y = GetCoords()
Actors.StopMoving('PLAYER')
Actors.MoveTo('PLAYER',x,3300,1)
WalkWait()
local c = Sys.Val(right(Maps.LayerCodeName,3))
c = c - 1
local lay = "#"..right("00"..c,3)
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer(lay)
SpawnPlayer("Einde")
TurnPlayer("South")
end

function BossNotYet()
Actors.StopMoving('PLAYER')
MapText("BOSSNOTYET")
Actors.MoveToSpot("PLAYER","BossNotYetSpot")
end

function AwardPoints()
if not (Done('&DONE.COMPLETE.JUNKYARD')) then 
   MapEXP()
   CSay("Let's award the player for besting this place")
else
	 CSay("The player already has his/her award!") 
   end
end

function UnderTheShip()
if Done("&DONE.OBTAINEDHAWK") then return end
if CVV("&GOT.HAWK") then return end
PartyPop("Ship")
MapText("HAWK")
Maps.Obj.Kill('Shadow',1)
LoadMap("Hawk","Bridge")
SpawnPlayer("Welcome")
MapText("ARRIVAL.KICKOFF")
Var.D("$HAWK","KICKOFF") -- This var will determine what the characters will say when you speak to them on board the Hawk. 
end

function Boss()
CleanCombat()
Var.D("$COMBAT.BACKGROUND","JunkYard.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE2","Boss/SupaQual")
Var.D("$COMBAT.ALTCOORDSFOE2","400,500")
if not Done("&SUPAQUAL") then Var.D("%COMBAT.LVFOE2",MapLevel()*10) else Var.D("%COMBAT.LVFOE2",round(MapLevel()/10)) end
RandomBossTune()
StartCombat()
end

function CLICK_ARRIVAL_ToObservatorium()
TelEffect(TEL_OUT)
LoadMap("LostPlanet_Bonus_SpaceObservatorium")
SpawnPlayer('SPOT_Transporter','South')
end

function GALE_OnLoad()
Music("Dungeon/Vuilnisbelt.ogg")
SetScrollBoundaries(0,0,0,2560)
ZA_Enter("Next",Next)
ZA_Enter("Prev",Prev)
ZA_Enter("Award",AwardPoints)
ZA_Enter("UnderTheShip",UnderTheShip)
if not CVV("&GOT.HAWK") then ZA_Enter("BossNotYet",BossNotYet) end
AddClickable('ToObservatorium')
CSay("Welcome to the junkyard")
end
