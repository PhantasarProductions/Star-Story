--[[
**********************************************
  
  Volcania - Volcanic Plains.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
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
 
version: 16.02.08
]]

AltComeInFromNorth = { [6]=2673 }
AltComeInFromSouth = {}
AltComeIn = { S = AltComeInFromNorth, N=AltComeInFromSouth }
NSPos = { S = 96, N = 3385}

function LayerNumber()
return Sys.Val(right(Maps.LayerCodeName,3))
end

function NZ(NS)
local oldplay = Actors.Actor("PLAYER")
local x,y = oldplay.X,oldplay.Y
local go = { N=-1, S = 1}
local lay = LayerNumber()+go[NS]
Maps.Obj.Kill("PLAYER")
Maps.GotoLayer("#00"..lay)
SpawnPlayer('START')
local newplay = Actors.Actor("PLAYER")
newplay.y = AltComeIn[NS or 'S'][lay] or NSPos[NS or 'S']
newplay.x = oldplay.x
end

function North() NZ('N') end
function South() NZ('S') end

function MAP_FLOW()
local play = Actors.Actor("PLAYER")
if play.Y>3420 then South() end
if play.Y<64   then North() end
if (not dactiv) and Maps.LayerCodeName=='#006' then
   MS.Run("TRANS",'ActivatePad',"Start")
   CSay("Activating pad")
   dactiv = true
   end
end

function GALE_OnLoad()
Music("Dungeon/Motherlode")
ZA_Enter("N006",NZ,"N")
end
