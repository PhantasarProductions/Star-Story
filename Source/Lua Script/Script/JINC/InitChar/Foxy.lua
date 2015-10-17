--[[
**********************************************
  
  Foxy.lua
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
 
version: 15.10.18
]]
skill = Sys.Val(Var.C("%SKILL"))
ch = "Foxy"
RPGChar.SetData("Foxy","INVITEM1","HEALINGCAPSULE")
RPGStat.SetStat("Foxy","INVAMNT1",3)
RPGChar.SetData("Foxy","INVITEM2","FIRSTAIDKIT")
RPGStat.SetStat("Foxy","INVAMNT2",7)
RPGChar.SetData("Foxy","INVITEM2","ANTIDOTE")
RPGStat.SetStat("Foxy","INVAMNT2",8)
--RPGChar.DefStat("Foxy","AMMO_BASE",6)
RPGChar.DefStat("Foxy","Level",30/skill)
RPGStat.AddList("Foxy","ABL","FOXY_MULTISTAB")
RPGStat.AddList("Foxy","ABL","FOXY_PICKPOCKET")
RPGStat.DefStat(ch,"SR_BASE_Poison",30/skill)
RPGStat.DefStat(ch,"SR_BASE_Paralysis",math.ceil(99/skill))
RPGStat.DefStat(ch,"SR_BASE_Disease",60/skill)
RPGStat.DefStat(ch,"SR_BASE_Will",100-((skill-1)*10))
RPGStat.DefStat(ch,"SR_BASE_Block",72/skill)
RPGStat.DefStat(ch,"SR_BASE_Death",90/skill)
RPGStat.DefStat(ch,"SR_BASE_Damned",70-(skill*10))

Console.Write("Let's welcome Foxy!",0,255,0)
