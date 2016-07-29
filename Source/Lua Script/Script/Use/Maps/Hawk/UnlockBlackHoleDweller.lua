--[[
**********************************************
  
  UnlockBlackHoleDweller.lua
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
 
version: 16.07.30
]]
function CheckOutBlackHoleDweller()
  -- All stuff required to unlock this.
  local quests2check = {
                           '&DONE.EXCALIBUR.FLOOR20.REACHED',             -- Floor 20 reached of the final dungeon.
                           "&DONE.NIZOZEMSKA.DARKGRAVEYARD.COMPLETE",     -- Dark Graveyard Nizozemska
                           '&RACHEL.DONE.AIROM.STUFF',                    -- Airom complete Phantasar
                           "&DONE.PHANTASAR.GHOSTHOUSE.COMPLETE",         -- Ghost house complete Phantasar
                           "&DONE.BLACKCASTLE",                           -- Black Castle complete Physillium
                           "&DONE.SECRETDUNGEON.VOLCANIA.CAVES",          -- Volcania Caves Volcania
                           "&DONE.SECRETDUNGEON.SEWERS",                  -- Sewers Vulpina
                           "&DONE.SECRETDUNGEON.EUGORVNIA.CAVES",         -- Eugorvnia Caves Ysperon
                           "&DONE.SECRET.DARK_CAVES_SHILINGTON",          -- The Dark Caves of Shilington The Lost Planet
                           "&DONE.ENTRANCE.ENTER.OBSERVATORIUM",          -- Space Observatorium The Lost Planet
                           "&DONE.MIDBOSS"                                -- Mid-Boss defeated Poloqor
                       }
   -- Check it all out                       
   for q in each(quests2check) do
       if not CVV(q) then
          CSay("-- Black Hole Dweller Requirement not set: "..q) 
          return 
          end
   end
   -- If not yet set then do it!
   if Done("&DONE.BLACKHOLEDWELLER.UNLOCKED") then return end
   ActivateRemotePad('Start','BlackHoleDweller','Black Hole','Black Hole Dweller\'s lair')
   MapText("BLACKHOLE")                       
end
