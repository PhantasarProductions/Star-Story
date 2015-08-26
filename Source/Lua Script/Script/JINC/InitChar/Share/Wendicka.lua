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
local skill = Sys.Val(Var.C("%SKILL"))
local ch = Var.C("$INITCHAR")
if skill==0 then skill=2 end
RPGStat.DefStat(ch,"SR_BASE_Poison",90/skill)
RPGStat.DefStat(ch,"SR_BASE_Paralysis",30/skill)
RPGStat.DefStat(ch,"SR_BASE_Disease",30)
RPGStat.DefStat(ch,"SR_BASE_Will",80/skill)
RPGStat.DefStat(ch,"SR_BASE_Block",18/skill)
RPGStat.DefStat(ch,"SR_BASE_Death",60/skill)
RPGStat.DefStat(ch,"SR_BASE_Damned",40-(skill*10))
