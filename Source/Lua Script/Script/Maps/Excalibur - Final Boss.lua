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
 
version: 16.08.02
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

LvMargin = {.50,.25,.10}                       

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

function GoddessRoom()
   SetScrollBoundaries(1,1,2,2)
   Music('Sys/Silence.ogg')
   Maps.Obj.Obj("Reggie").Visible = 0
   Maps.Remap()
end

function NPC_Goddess()
  -- Pre boss Scenario
  PartyPop("Goddess")
  Maps.Obj.Obj("Reggie").Visible = 1
  MapText("GODDESS1")
  KickReggie('West','POP_Foxy','Reggie')
  MapText('GODDESS2')
  -- Set it all up
  local lv=0
  for ch in each({'Wendicka','Crystal','Yirl','Xenobi','Foxy','Johnson'}) do
      lv = lv + RPGChar.Stat(ch,'Level')
  end
  lv = math.ceil(lv/6)
  CleanCombat()
  Var.D("$COMBAT.BACKGROUND","Phan - Dung.png") -- Just have some value, to prevent a crash
  Var.D("$COMBAT.ALTBACKGROUND","GoddessSpace")
  Var.D("$COMBAT.BEGIN","Default")
  Var.D("$COMBAT.FOE1","Goddess/Goddess")
  Var.D("$COMBAT.ALTCOORDSFOE1","300,427")
  Var.D("%COMBAT.LVFOE1",lv)
  Var.D("$COMBAT.MUSIC",'SpecialBoss/Spellbound.ogg')
  local adds = {}
  local add
  for i=1,NumAdds[skill] do
      repeat
         add = GoddessAddons[rand(1,#GoddessAddons)]
      until not tablecontains(adds,add)
      adds[#adds+1] = add
  end
  CSay("Adding "..#adds.." drones to the final boss fight")
  for i,a in ipairs(adds) do
      local ip = i + 1
      Var.D('$COMBAT.FOE'..ip,"Goddess/Add_"..a)
      Var.D('%COMBAT.LVFOE'..ip , rand(lv-(lv*LvMargin[skill]),lv))
      CSay('Added '..a..' as FOE'..ip)
  end
  Schedule('MAP','PostBoss') 
  -- Let the final battle begin
  StartCombat()
end

function PostBoss()
  Sys.Error("PostBoss not yet scripted")
end  

function GALE_OnLoad()
   Music('Sys/Silence.ogg') -- Let the normal music stop.
   if CVV("&DONE.LOVEJOY_IS_DEAD") then Music('Special/GameOver.ogg') end
   ZA_Enter('DIE_Lovejoy',DIE_Lovejoy)
   ZA_Enter("Goddess_Room",GoddessRoom)
end
