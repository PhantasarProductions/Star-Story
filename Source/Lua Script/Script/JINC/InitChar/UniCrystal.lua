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
UniCrystal.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.09.11
]]
RPGChar.SetName("UniCrystal","Crystal")
RPGChar.SetData("UniCrystal","Pic","UNIFORM")
RPGChar.DefStat("UniCrystal","PXM",26)
RPGChar.SetData("UniCrystal","INVITEM1","ADHBANDAGE")
RPGStat.SetStat("UniCrystal","INVAMNT1",5)
RPGChar.SetData("UniCrystal","INVITEM2","ADHBANDAGE")
RPGStat.SetStat("UniCrystal","INVAMNT2",5)
RPGChar.SetData("UniCrystal","INVITEM3","BANDAGE")
RPGStat.SetStat("UniCrystal","INVAMNT3",2)

Console.Write("Say hi to Crystal in uniform!",0,255,0)

RPGChar.DefStat("UniCrystal","AMMO_BASE",8)

local f = loadstring(JCR6.LoadString("Script/JINC/InitChar/Share/Crystal.lua")); f()
