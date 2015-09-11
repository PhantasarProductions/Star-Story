--[[
 **********************************************
  
  This file is part of a closed-source 
  project by Jeroen Petrus Broks and should
  therefore not be in your pocession without
  his permission which should be obtained 
  PRIOR to obtaining this file.
  
  You may not distribute this file under 
  any circumstances or distribute the 
  binary file it procudes by the use of 
  compiler software without PRIOR written
  permission from Jeroen P. Broks.
  
  If you did obtain this file in any way
  please remove it from your system and 
  notify Jeroen Broks you got it somehow. If
  you have downloaded it from a website 
  please notify the webmaster to remove it
  IMMEDIATELY!
  
  Thank you for your cooperation!
  
  
 **********************************************
Briggs.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.09.11
]]
lvWendicka = RPGStats.Stat("UniWendicka","Level")
lvCrystal  = RPGStats.Stat("UniCrystal", "Level")
lvTotal    = lvWendicka + lvCrystal
lvBriggs   = (lvTotal/2)*20
if lvBriggs>10000 then lvBriggs = 10000 end
RPGStats.DefStat("Briggs","Level",lvBriggs)
-- RPGStats.DefData("Briggs","NoEXP","YES")
RPGStats.Points("Briggs","EXP").Maximum=0



local skill = Sys.Val(Var.C("%SKILL"))
if skill==0 then skill=2 end

RPGStat.DefStat("Briggs","SR_BASE_Poison",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Paralysis",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Disease",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Will",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Block",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Death",90/skill)
RPGStat.DefStat("Briggs","SR_BASE_Damned",90/(skill))
RPGChar.DefStat("Briggs","AMMO_BASE",8)

RPGChar.ScriptStat("Briggs","BASE_Agility","Script/CharStats/Briggs.lua","Briggs_Agility")
