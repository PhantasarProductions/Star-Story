--[[
/**********************************************
  
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
  
  
 **********************************************/
 



Version: 15.07.20

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
