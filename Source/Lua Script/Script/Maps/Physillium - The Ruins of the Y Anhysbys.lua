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
 
version: 15.11.21
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

function Boss()
SetSchuif({'BDL','BDR'},"Open")
CleanCombat()
local lv=1000000 -- In case you cheat your way around this, the boss will be impossible to beat! Heh heh heh!
local players,totallevel=0,0
local tag
for i=0,5 do
    tag = RPGChar.PartyTag(i)
    if tag~="" then
       players = players + 1
       totallevel = totallevel + RPGChar.Stat(tag,"Level")
       end
    end
if players>0 and totallevel>0 then lv = math.ceil(totallevel/players) end    
Var.D("$COMBAT.BACKGROUND","Y Anhysbys.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE2","Boss/BigLion")
Var.D("%COMBAT.LVFOE2",lv)
Var.D("$COMBAT.ALTCOORDSFOE2","300,400")
if skill==3 then
   Var.D("$COMBAT.FOE1","Reg/Lion")
   Var.D("$COMBAT.FOE2","Reg/Lion")
   Var.D("%COMBAT.LVFOE1",lv)
   Var.D("%COMBAT.LVFOE2",lv)
   end
RandomBossTune()
StartCombat()   
end



function GALE_OnLoad()
local l = Maps.LayerCodeName
Music("Dungeon/The Complex.ogg")
ZA_Enter("WendickaSecret",WendickaSecret)
ZA_Enter("WendickaStop",WendickaStop)
ZA_Enter("Wendicka_Rejoin",WendickaRejoin)
AddClickable("Puzzle1")
Maps.GotoLayer("#001") -- Puzzle #1
Schuif = { Ga={}, Obj={} } -- Force data removal from a failed fix earlier
InitSchuif('PDL#001',-60,-1)
InitSchuif('PDR#001', 60,-1)
if CVV("&SOLVED.ANHYSBYS.PD[#001]") then SetSchuif({'PDL#001','PDR#001'},"Open"); end
Maps.GotoLayer("#003") -- Puzzle #2
InitSchuif('PDL#003',-60,-1)
InitSchuif('PDR#003', 60,-1)
if CVV("&SOLVED.ANHYSBYS.PD[#003]") then SetSchuif({'PDL#003','PDR#003'},"Open"); end
Maps.GotoLayer("#004") -- Boss door
InitSchuif('BDL',-44,-1)
InitSchuif('BDR', 44,-1)
Maps.GotoLayer("#005") -- Exit door
InitSchuif('EDL',-40,-1)
InitSchuif('EDR', 40,-1)
ZA_Enter( "OpenED",function() SetSchuif({'EDL','EDR'}, 'Open') Maps.Obj.Obj('EDB').Impassible=0 Maps.Remap() end)
ZA_Enter("CloseED",function() SetSchuif({'EDL','EDR'},'Dicht') Maps.Obj.Obj('EDB').Impassible=1 Maps.Remap() end)
Maps.GotoLayer(l)
end
