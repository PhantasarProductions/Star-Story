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
Crystal.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.09.02
]]
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
if skill==0 then skill=2 end
local ch = Var.C("$INITCHAR")
RPGStat.DefStat(ch,"SR_BASE_Poison",60/skill)
RPGStat.DefStat(ch,"SR_BASE_Paralysis",50/skill)
RPGStat.DefStat(ch,"SR_BASE_Disease",60)
RPGStat.DefStat(ch,"SR_BASE_Will",60/skill)
RPGStat.DefStat(ch,"SR_BASE_Block",75/skill)
RPGStat.DefStat(ch,"SR_BASE_Death",33/skill)
RPGStat.DefStat(ch,"SR_BASE_Damned",30-(skill*10))
