--[[
**********************************************
  
  Phantasar - Airom.lua
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
 
version: 16.07.29
]]
-- @USE Phantasar.lua



function GALE_OnLoad()
   Music('Dungeon/Dungeon1.ogg')
   MapShow('BASE')
   for i=1,5 do
       ZA_Enter('ShowSecret'..i,MapShow,"BASE,SECRET"..i)
       ZA_Enter('HideSecret'..i,MapShow,"BASE")
   end
   NPC_GREEN_1 = savespot.green
   NPC_GREEN_2 = savespot.green
   NPC_GREEN_3 = savespot.green
   NPC_GREEN_4 = savespot.green
   NPC_GREEN_5 = savespot.green
   NPC_GREEN_6 = savespot.green
   NPC_GREEN_7 = savespot.green
   NPC_GREEN_8 = savespot.green
   NPC_GREEN_9 = savespot.green
   NPC_GREEN_0 = savespot.green
   NPC_RED_1   = savespot.red
   if skill>1 then
      for i=0,9 do
          if rand(1,({6,2})[skill-1])==1 then -- Yeah, at harder difficulty settings, less savespots. 
             Maps.Obj.Kill('NPC_GREEN_'..i) 
          end
      end    
   end       
end
   
