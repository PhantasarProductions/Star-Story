--[[
/* 
  Combat - Action

  Copyright (C) 2015 Jeroen P. Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
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

*/



Version: 15.08.01

]]
function AblEffect(ag,ai,act,tg,ti)
local abl=act.Item
local cha = FighterTag(ag,ai)..""
local cht = FighterTag(tg,ti).."" -- This way of forming FORCES a <nil> value error if this should happen. I need to know if the evil's done here or not :)
-- Cure status changes (this must always be the first thing to do)
-- Heal absolute or by percent
if abl.Healing and abl.Healing>0 then
   (({ Absolute = function() Heal(tg,ti,abl.Healing) end,
      Percent  = function()
                 local hpt = RPGChar.Points(cht,"HP")
                 local hpm = hpt.Maximum
                 local points = (hpm/100)*abl.Healing
                 Heal(tg,ti,points)
                 end
   })[abl.HealingType] or function() Sys.Error("Unknown healing type: "..sval(abl.HealingType)) end )()               
   end
-- Hurt target (can also heal if the element is being absored)
-- Scripted stuff
-- Cause status changes (this must always be the last thing to do)
end; AbilityEffect = AblEffect

ActionFuncs = {}

function ActionFuncs.Error(g,i,act)
Sys.Error("Unknown Action Tag: "..sval(act.Act))
end

function ActionFuncs.SHT(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
if RPGChar.Points(ch,"AMMO",1).Have<=0 then return MINI(RPGChar.Name(ch).." cannot shoot! Out of ammo!") end
local tg,ti = TargetFromAct(act)
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." shoots")
-- Animate character 
--[[ Comes later ]]
-- SpellAni for the projectile
RPGChar.NewData(ch,"ShootSpellAni","PhotonGun") -- If not properly set, we'll assume the photon gun animation is required. 
SpellAni[RPGChar.GetData(ch,"ShootSpellAni")](ag,ai,tg,ti)
-- Perform Attack
Attack(ag,ai,act)
-- Remove one bullet
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO",1).Have - 1
end


function ActionFuncs.RLD(ag,ai,act)
SFX("Audio/SFX/Gun-Cocking-Sound.ogg")
if ag~="Hero" then Sys.Error("Reloading can only be done by heroes") end
local t = FighterTag(ag,ai)
local h = {UniWendicka="her",UniCrystal="her"}
RPGChar.Points(t,"AMMO").Have = RPGChar.Points(t,"AMMO").Maximum
MINI( RPGChar.GetName(t) .. " has reloaded "..(h[t] or "his").." gun")
end 


function ActionFuncs.ATK(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
local tg,ti = TargetFromAct(act)
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." attacks")
-- Animate character 
--[[ Comes later ]]
-- Perform Attack
Attack(ag,ai,act)
end

function ActionFuncs.EAI(ag,ai,act)
if not act.EAI then Sys.Error("Illegally set up act for EAI") end
NewMessage(act.Item.Name,ItemIconCode(act.ItemCode))
local ch = FighterTag(ag,ai)
local tg,ti
local function SingleEffect(ag,ai,act) AbilityEffect(ag,ai,act,act.TargetGroup,act.TargetIndividual) end
local function GroupEffect(ag,ai,act)
               local i
               local tg = act.TargetGroup
               for i,_ in pairs(Fighters[tg]) do AbilityEffect(ag,ai,act,tg,i) end
               end
(({
      ["1F"] = SingleEffect,
      ["1A"] = SingleEffect,
      ["OS"] = SingleEffect,
      ["AA"] = GroupEffect,
      ["AF"] = GroupEffect,
      ["EV"] = function(ag,ai,act)
               local tg,ti,group
               for tg,group in pairs(Fighters) do for ti,_ in pairs(group) do AbilityEffect(ag,ai,act,tg,ti) end end
               end
      })[act.Item.Target] or function() Sys.Error("EAI: Unknown target type"..act.Item.Target) end)(ag,ai,act)
end

function ActionFuncs.ITM(ag,ai,act)
if ag=="Foe" then -- Foes should use "FAI" in stead.
   MINI("Action skipped! Enemies cannot use items",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did",255,0,0)
   return
   end
local ch = FighterTag(ag,ai)   
if RPGChar.Stat(ch,"INVAMNT"..act.ItemSocket)<=0 then
   MINI("Action Cancelled!",255,0,0)
   MINI("Item socket empty",255,180,0)
   return
   end
RPGChar.DecStat(ch,"INVAMNT"..act.ItemSocket)   
act.EAI = true
ActionFuncs.EAI(ag,ai,act)
end   
