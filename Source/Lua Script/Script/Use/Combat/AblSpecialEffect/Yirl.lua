--[[
  Yirl.lua
  Version: 15.11.02
  Copyright (C) 2015 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]
-- @IF IGNORE
AblSpecialEffect = {}
-- @FI

function AblSpecialEffect.TriggerHappy(ag,ai,tg,ti,act)
local me = Fighters[ag][ai].Tag
local tgt = Fighters[tg][ti].Tag
local ammo = RPGChar.Points(me,"AMMO")
local ret
if ammo.Have==0 then MINI("Can't trigger happy without ammo") return true end
for i=1,ammo.Have do
      if not Fighters[tg][ti] then return end -- Stop shooting if the enemy is dead already
      if RPGChar.Points(tgt,"HP").Have==0 then return end
      -- ActionFuncs.SHT(ag,ai,act)
      SpriteAnim[ag](ai,act)
      White()
      SpellAni[RPGChar.GetData(me,"ShootSpellAni")](ag,ai,tg,ti)
      -- Perform Attack
      Attack(ag,ai,act)
      ammo.Have=ammo.Have-1
      ret=true      
      end
            
return true
end

      

function AblSpecialEffect.FollowMe(ag,ai)
for i,data in pairs(Fighters.Hero) do
    if i~=ai and data.Gauge<9998 then data.Gauge=9998 end
    end
end

function AblSpecialEffect.Taunt(ag,ai,tg,ti,act)
local me = Fighters[ag][ai]
local tg = Fighters[tg][ti]
local ta = tg.Act
local it
if tg.Gauge<=10000 then return end -- Only those preparing a move can do
if ta=='FAI' then
   it = ItemGet(ta.Item)
   if it.Untauntable then return end -- Sorry, ya can't taunt this move!
elseif ta~='ATK' then return end
ta.TargetGroup=ag
ta.TargetIndividual=ai
CharReport(tg,ti,"Taunted!",{0,100,170})
return true       
end    
