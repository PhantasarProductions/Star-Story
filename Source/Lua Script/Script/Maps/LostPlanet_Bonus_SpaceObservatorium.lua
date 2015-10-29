--[[
**********************************************
  
  LostPlanet_Bonus_SpaceObservatorium.lua
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
 
version: 15.10.29
]]

-- @USE /Script/Use/Maps/Gen/Schuif.lua

function CLICK_ARRIVAL_Transporter()
TransporterPad('Observatorium')
end

function MAP_FLOW()
-- Control the sliding doors
DoSchuif()
-- Control the space areas
local space = Maps.Obj.Obj('SPACE')
space.X = Maps.CamX
space.Y = Maps.CamY
space.W=800
space.H=700
end

function CLICK_ARRIVAL_EntranceConsole()
local d = Done('&DONE.ENTRANCE.OBSERVATORIUM')
if GetActive()~="Wendicka" then return MapText("UNIX.NOTWENDICKA") end
if not d then MapText('UNIX1') end
SetSchuif("UnixD1L","Open")
SetSchuif("UnixD1R","Open")
Maps.Obj.Obj("UnixD1L").Impassible = 0
Maps.Obj.Obj("UnixD1R").Impassible = 0
Maps.Remap()
if not d then
   for i=1,40 do
       DoSchuif()
       DrawScreen()
       Flip()
       end 
   MapText('UNIX1OPEN') 
   end
end

function Enter()
MapShow('Observe1')
if not Done("&DONE.ENTRANCE.ENTER.OBSERVATORIUM") then MapText("ENTER") end
-- Safety measure. If the doors are somehow closed open them to rule out every possibility the player might get locked up.
SetSchuif("UnixD1L","Open")
SetSchuif("UnixD1R","Open")
Maps.Obj.Obj("UnixD1L").Impassible = 0
Maps.Obj.Obj("UnixD1R").Impassible = 0
Maps.Remap()
end


function GALE_OnLoad()
Music("Dungeon/Observatorium.ogg")
AddClickable("Transporter")
ZA_Enter("Transporter",MapShow,'Entrance')
ZA_Enter('Entrance'   ,MapShow,'Entrance')
ZA_Enter("ToCorr1L",   MapShow,'Corridor1')
ZA_Enter("ToCorr1R",   MapShow,'Corridor1')
ZA_Enter("ToCorr1U",   MapShow,'Corridor1')
-- The sliding doors Entrance part
InitSchuif('DtC1LL',-40,0)
InitSchuif('DtC1LR', 40,0)
InitSchuif('DtC1RL',-40,0)
InitSchuif('DtC1RR', 40,0)
OpenSchuif('OpenCorr1L',{'DtC1LL','DtC1LR'})
OpenSchuif('OpenCorr1R',{'DtC1RL','DtC1RR'})
-- Unix Door 1
AddClickable('EntranceConsole')
InitSchuif("UnixD1L",-40,0)
InitSchuif("UnixD1R", 40,0)
-- Enter the great hall
ZA_Enter("Enter",Enter)
-- Enter/leave the second corridor
ZA_Enter("EndObs1",Enter)
ZA_Enter("Obs1Cor2",MapShow,"Observe1,Corridor2")
ZA_Enter("Corridor2_S",MapShow,"Corridor2")
-- Sliding doors between coordoor 2 and restrooms
InitSchuif('DfC2LL',-40,0)
InitSchuif('DfC2LR', 40,0)
InitSchuif('DfC2RL',-40,0)
InitSchuif('DfC2RR', 40,0)
OpenSchuif('OpenCorr2L',{'DfC2LL','DfC2LR'})
OpenSchuif('OpenCorr2R',{'DfC2RL','DfC2RR'})
ZA_Enter('ShowCorridor2',MapShow,"Corridor2")
for i=1,3 do
    ZA_Enter('toplay'..i,MapShow,"Plee")
    end
end
