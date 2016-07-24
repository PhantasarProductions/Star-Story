--[[
**********************************************
  
  McLeen.lua
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
 
version: 16.07.24
]]
-- @IF IGNORE
Foe_AI = {}  -- Ignored, but this fools my Outliner in Eclipse ;)
-- @FI

function DetectCrystal()
   local retPresent = nil
   local retLastMan = true
   local ch,HP
   for i=1,3 do
      ch = Fighters.Hero[i].Tag
      HP = RPGChar.Points(ch,'HP').Have
      retLastMan = retLastMan and ((HP>0 and ch=='Crystal') or (HP==0 and ch~='Crystal'))
      if ch=='Crystal' then retPresent = i end
   end
   retLastMan = retLastMan and retPresent
   return retPresent,retLastMan
end



function Foe_AI.McLeen(pos)
  repeat
   local me = Fighters.Foe[pos].Tag
   Foe_AI.Default(pos)
   local Crystal,CrystalLastManStanding = DetectCrystal()
   if not Crystal then return end -- If Crystal is not present, anything goes, so let's not concern the system more than we have to.
   if CrystalLastManStanding then
      Done('&GAMEOVER')
      LAURA.Flow('Field')
      return -- End the game if Crystal is the "last man standing".
   end
   local myact = Act.Foe[pos]
   local ok = true
   local item = {Target='1F'} 
   if item.Act=='FAI' then item = ItemGet(myact.Item) end
   if item.Target == 'AF' then 
      ok=false
   elseif item.Taget == '1F' then
      ok = ok and Fighters[myact.TargetGroup][myact.TargetIndividual].Tag~='Crystal'    
      end      
  until ok  
end  
