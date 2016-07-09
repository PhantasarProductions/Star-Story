--[[
**********************************************
  
  ExHuRU_AI.lua
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
 
version: 16.07.09
]]
-- @IF IGNORE
Foe_AI = {}  -- Ignored, but this fools my Outliner in Eclipse ;)
-- @FI




function Foe_AI.ExHuRU(pos)
  local me = Fighters.Foe[pos].Tag
  Foe_AI.Default(pos)
  local myact = Act.Foe[pos]
  local Wendicka=nil
  for i=0,3 do
      if RPGChar.PartyTag(i)=="Wendicka" and RPGStat.Points("Wendicka","HP").Have>0 then Wendicka=i+1 end
  end
  if not Wendicka then
     CSay("Wendicka isn't there, so let's kill everybody")
     DefaultProcess.Abl(me,"ZZZ_TOTALDESTRUCTION",myact)
     myact.TargetGroup='Hero'
  else
     CSay("Wendicka = "..Wendicka)
     myact.TargetIndividual = Wendicka   
  end   
end
