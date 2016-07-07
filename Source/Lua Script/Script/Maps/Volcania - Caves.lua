--[[
**********************************************
  
  Volcania - Caves.lua
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
 
version: 16.07.07
]]

bosstune = "SpecialBoss/DeathPredator.ogg"

function Boss()
  CleanCombat()
  Var.D("$COMBAT.AltEnemyBuild","SUPERFOE_BuildBossVolcania")
  Var.D("$COMBAT.BACKGROUND","Volcano.png")
  Var.D("$COMBAT.MUSIC",'SpecialBoss/DeathPredator.ogg') 
  Var.D("$COMBAT.BEGIN","Default")
  Var.D("$COMBAT.FOE1","Boss/FireSpiderYoung")
  Var.D("%COMBAT.LVFOE1",MapLevel())
  Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
  StartCombat()
end

function EndDungeon()
   if Done("&DONE.SECRETDUNGEON.VOLCANIA.CAVES") then return end
   MapEXP()
   Award("SECRETDUNGEON_VOLCANIACAVES")
   ;(inc or Inc)("%AURINARATE",100)
end   

function GALE_OnLoad()
     Music("Dungeon/Dungeon1.ogg")
     ZA_Enter("EndDungeon",EndDungeon)
end     

-- @USE /Script/Use/Maps/Gen/Next.lua
