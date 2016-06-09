--[[
**********************************************
  
  ExHuRU.lua
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
 
version: 16.06.09
]]
function BOSS_ExHuRU()
  local lv = RPGChar.Stat("ExHuRU","Level")
	for s in each({"Strength","Defense","Will","Resistance","Agility","Accuracy","Evasion"}) do
		RPGChar.LinkStat('ExHuRU',"FOE_1","BASE_"..s)
  end
  RPGChar.DefStat("FOE_1","BASE_HP",lv*(250)*skill)
  local hp = RPGChar.Points("FOE_1","HP")
  hp.Maximum = RPGChar.Stat("FOE_1","BASE_HP")
  hp.Have = hp.Maximum
end

