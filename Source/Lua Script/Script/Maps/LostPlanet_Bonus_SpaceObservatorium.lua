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
 
version: 15.10.28
]]

-- @USE /Script/Use/Maps/Gen/Schuif.lua

function CLICK_ARRIVAL_Transporter()
TransporterPad('Observatorium')
end

MAIN_FLOW = DoSchuif


function GALE_OnLoad()
Music("Dungeon/Observatorium.ogg")
AddClickable("Transporter")
ZA_Enter("Transporter",MapShow,'Entrance')
ZA_Enter('Entrance'   ,MapShow,'Entrance')
ZA_Enter("ToCorr1L",   MapShow,'Corridor1')
ZA_Enter("ToCorr1R",   MapShow,'Corridor1')
-- The sliding doors
InitSchuif('DtC1LL',-40,0)
InitSchuif('DtC1LR', 40,0)
InitSchuif('DtC1RL',-40,0)
InitSchuif('DtC1RR', 40,0)
OpenSchuif('OpenCorr1L',{'DtC1LL','DtC1LR'})
OpenSchuif('OpenCorr1R',{'DtC1RL','DtC1RR'})
end
