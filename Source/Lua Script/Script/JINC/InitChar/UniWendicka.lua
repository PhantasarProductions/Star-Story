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
 



Version: 15.08.26

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
