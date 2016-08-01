--[[
**********************************************
  
  Excalibur - Final Boss.lua
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
 
version: 16.08.01
]]
-- @USE /Script/Use/Maps/Gen/SchuifNext.lua

GoddessAddons = {
                     'Gunner',
                     "FlameThrower",
                     "IceCannon",
                     "WaterGun",
                     "WindGun",
                     "RockThrower",
                     "LightGun",
                     "DarkGun"
                }

if Var.C('%SKILL')~="1" then
   for _,a in ipairs({
                        'VenomGun',
                        "VirusGun",
                        "Trq",
                        "BlockGun",
                        "ConfuseGun"
                    }) do
         GoddessAddons[#GoddessAddons+1] = a                    
   end                    
end

NumAdds = {2,4,6}                                

function DIE_Lovejoy()
   if Done("&DONE.LOVEJOY_IS_DEAD") then return end
   Music('Special/GameOver.ogg')
   PartyPop("LJ","North")
   MapText("LOVEJOY")
   PartyUnPop()
end

function NPC_Lovejoy()
   local p = upper(GetActive())
   MapText("LOVEJOY.DEAD."..p)
end

function GALE_OnLoad()
   Music('Sys/Silence.ogg') -- Let the normal music stop.
   if CVV("&DONE.LOVEJOY_IS_DEAD") then Music('Special/GameOver.ogg') end
   ZA_Enter('DIE_Lovejoy',DIE_Lovejoy)
end
