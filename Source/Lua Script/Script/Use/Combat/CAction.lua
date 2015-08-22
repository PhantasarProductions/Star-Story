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
