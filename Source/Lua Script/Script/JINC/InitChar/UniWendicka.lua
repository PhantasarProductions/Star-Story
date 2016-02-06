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
UniWendicka.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.09.11
]]
RPGChar.SetName("UniWendicka","Wendicka")
RPGChar.SetData("UniWendicka","Pic","UNIFORM")
RPGChar.DefStat("UniWendicka","PXM",52)
RPGChar.SetData("UniWendicka","INVITEM1","ADHBANDAGE")
RPGStat.SetStat("UniWendicka","INVAMNT1",5)
RPGChar.SetData("UniWendicka","INVITEM2","BANDAGE")
RPGStat.SetStat("UniWendicka","INVAMNT2",1)
RPGStat.AddList("UniWendicka","ABL","WENDICKA_SHOCK")
RPGChar.ScriptStat("UniWendicka","ER_Lightning","Script/CharStats/Wendicka.lua","ER_Lightning")
RPGChar.ScriptStat("UniWendicka","ER_Water"    ,"Script/CharStats/Wendicka.lua","ER_Water")
RPGChar.DefStat("UniWendicka","AMMO_BASE",8)
Console.Write("Say hi to Wendicka in uniform!",0,255,0)
Var.D("%WENDICKA.NEED",15)

local f = loadstring(JCR6.LoadString("Script/JINC/InitChar/Share/Wendicka.lua")); f()
