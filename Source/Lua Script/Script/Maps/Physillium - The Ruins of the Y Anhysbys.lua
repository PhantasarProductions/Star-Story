--[[
**********************************************
  
  Physillium - The Ruins of the Y Anhysbys.lua
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
 
version: 15.11.18
]]
-- @USE /Script/Use/Maps/Gen/Schuif.lua
-- @USE /Script/Use/Maps/Gen/Next.lua

function WendickaSecret()
if InParty("Wendicka") and (not Done("&DONE.WENDICKA.YANHYSBYS.SECRETPASSAGE.CRYSTAL.MULTIBLAST.ANNOUNCED")) then
   MapText("WENDICKA_SECRET")
   end
end

function StartPuzzle()
MS.Load("MINIGAME","Script/MiniGame/MemoryAnhysbys.lua")
LAURA.Flow("MINIGAME")
end

CLICK_ARRIVAL_Puzzle1 = StartPuzzle

function Open_PD()
local l = Maps.LayerCodeName
if Done("&SOLVED.ANHYSBYS.PD["..l.."]") then return end
SetSchuif({'PDL'..l,'PDR'..l},"Open")
MapEXP()
Maps.Obj.Obj("PDL"..l).Impassible=0
Maps.Obj.Obj("PDR"..l).Impassible=0
Maps.PermaWrite('Maps.Obj.Obj("PDL'..l..'").Impassible=0')
Maps.PermaWrite('Maps.Obj.Obj("PDR'..l..'").Impassible=0')
Maps.PermaWrite('Maps.Obj.Obj("PDL'..l..'").X='..Sys.Val(Maps.Obj.Obj("PDL"..l).X-60))
Maps.PermaWrite('Maps.Obj.Obj("PDR'..l..'").X='..Sys.Val(Maps.Obj.Obj("PDL"..l).X+60))
Maps.Remap()
end

function WendickaStop()
if CVV("&DONE.ANHYSBYS.WENDICKAREJOIN") then return end
Actors.StopWalking('PLAYER')
MapText("WENDICKA_STOP")
Actors.WalkToSpot('PLAYER',"Start")
end

function WendickaRejoin()
if Done("&DONE.ANHYSBYS.WENDICKAREJOIN") then return end
PartyPop("Wen")
MapText("WENDICKA_REJOIN")
PartyUnPop()
RPGChar.SetParty(4,"Wendicka")
ReLevel("Wendicka","Crystal")
MS.Run("TRANS","FixPadLayer","TRANSWENDICKA")
Maps.Obj.Kill("Wendicka",1)
Var.D("$HAWK","ANHYSBYS.REJOIN")
end



function GALE_OnLoad()
local l = Maps.LayerCodeName
Music("Dungeon/The Complex.ogg")
ZA_Enter("WendickaSecret",WendickaSecret)
ZA_Enter("WendickaStop",WendickaStop)
ZA_Enter("Wendicka_Rejoin",WendickaRejoin)
AddClickable("Puzzle1")
Maps.GotoLayer("#001")
Schuif = { Ga={}, Obj={} } -- Force data removal from a failed fix earlier
InitSchuif('PDL#001',-60,-1)
InitSchuif('PDR#001', 60,-1)
if CVV("&SOLVED.ANHYSBYS.PD[#001]") then SetSchuif({'PDL#001','PDR#001'},"Open"); end
Maps.GotoLayer(l)
end
