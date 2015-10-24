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
 
version: 15.10.24
]]


function Next()
local x,y = PlayerCoords()
Actors.StopMoving('PLAYER')
Actors.MoveTo('PLAYER',x,-64)
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
local x,y = PlayerCoords()
Actors.StopMoving('PLAYER')
Actors.MoveTo('PLAYER',x,3300)
WalkWait()
local c = Sys.Val(right(Maps.LayerCodeName,3))
c = c - 1
local lay = "#"..right("00"..c,3)
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer(lay)
SpawnPlayer("Start")
TurnPlayer("South")
end

function BossNotYet()
Actors.StopMoving('PLAYER')
MapText("BOSSNOTYET")
Actors.MoveToSpot("PLAYER","BossNotYetSpot")
end


function GALE_OnLoad()
Music("Dungeon/Vuilnisbelt.ogg")
SetScrollBoundaries(0,0,0,2560)
ZA_Enter("Next",Next)
ZA_Enter("Prev",Prev)
if not CVV("&DONE.OBTAINEDHAWK") then ZA_Enter("BossNotYet",BossNotYet) end
CSay("Welcome to the junkyard")
end
