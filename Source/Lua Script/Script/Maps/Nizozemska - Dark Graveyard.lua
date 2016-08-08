--[[
**********************************************
  
  Nizozemska - Dark Graveyard.lua
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
 
version: 16.05.22
]]
function Bye()
   LoadMap('Nizozemska - Belioss','#007')
   Maps.GotoLayer('#007')   
   SpawnPlayer('FromSide')
end

function Boss()
BossLv = Bosslv or 100
if RPGChar.ListHas('Crystal','ARM','DOPING_SHOT')==1 then BossLv = BossLv + (50 *skill) end
local lv = BossLv
CleanCombat()
Var.D("$COMBAT.BACKGROUND","BOS - Kerkhof.png")
Var.D("$COMBAT.BEGIN","Default")
Var.D("$COMBAT.FOE2","Boss/Cultist Leader")
Var.D("%COMBAT.LVFOE2",lv)
if skill==3 then
   Var.D("$COMBAT.FOE1","Reg/Cultist")
   Var.D("$COMBAT.FOE3","Reg/Cultist")
   Var.D("%COMBAT.LVFOE1",rand(1,lv))
   Var.D("%COMBAT.LVFOE3",rand(1,lv))
   end
Var.D("$COMBAT.MUSIC","DUNGEON/AGNUS DEI X.OGG")
StartCombat()   
end

function Complete()
  Award("SECRETDUNGEON_DEATHBECOMESHER")
  if not Done("&DONE.NIZOZEMSKA.DARKGRAVEYARD.COMPLETE") then MapEXP() end
end

function GALE_OnLoad()
    Music("DUNGEON/AGNUS DEI X.OGG")
    ZA_Enter('Bye',Bye)
    ZA_Enter('Complete',Complete)
end
