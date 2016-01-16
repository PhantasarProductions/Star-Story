--[[
**********************************************
  
  Xenobi.lua
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
 
version: 15.11.24
]]

-- Set up levels
local skill = Sys.Val(Var.C("%SKILL")) -- CVV not supported here.
local crystallevel = RPGStat.Stat("Crystal","Level")
local xenobilevel = crystallevel + ({15,10,5})[skill]
if xenobilevel>150 then xenobilevel = crystallevel end -- Just make sure the cap isn't exceeded!
RPGStat.DefStat('Xenobi','Level',xenobilevel)

-- Spells
MS.Run("PARTY","XenobiLearn","ABL")

-- Status resistances
RPGStat.DefStat("Xenobi","SR_BASE_Poison",96/skill)
RPGStat.DefStat("Xenobi","SR_BASE_Paralysis",66/skill)
RPGStat.DefStat("Xenobi","SR_BASE_Disease",72/skill)
RPGStat.DefStat("Xenobi","SR_BASE_Will",100)
RPGStat.DefStat("Xenobi","SR_BASE_Block",90/skill)
RPGStat.DefStat("Xenobi","SR_BASE_Death",84/skill)
RPGStat.DefStat("Xenobi","SR_BASE_Damned",100)
