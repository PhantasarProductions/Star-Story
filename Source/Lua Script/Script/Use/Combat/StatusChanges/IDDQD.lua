--[[
  IDDQD.lua
  Version: 15.12.09
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
-- @IF IGNOREME
-- These lines are only meant to "fool" the outline routine in Eclipse ;)
-- The @IF IGNOREME and @FI command will make GALE ignore these lines. :)
StatusResistance = {}
StatusAltStat = {}
StatusDrawFighter = {}
StatusAltFatal = {}
StatusAltUltraWeak = {}
StatusAltWeak = {}
StatusAltNormalHurt = {}
StatusAltHalved = {}
-- @FI



function NoHurt(ch,hp,element)
local dodmg = 0
local report = "NO EFFECT!"      
local r,g,b = 255,180,0
local rate = { Hero = { 50, 25, 5 }, Foe = {5,10,25} }
local g = "Foe"
-- if left(g,1)=="FOE_" then g="Foe" end   -- Safetly in in case IDDQD ever becomes available to the player
if rand(1,rate[g][skill])==1 then RPGChar.RemList(ch,"STATUSCHANGE","IDDQD"); MINI(RPGChar.GetName(ch).."'s I.D.D.Q.D. effect has been neutralized") end
return dodmg,report,r,g,b
end

StatusAltFatal.IDDQD = NoHurt
StatusAltUltraWeak.IDDQD = NoHurt
StatusAltWeak.IDDQD = NoHurt
StatusAltNormalHurt.IDDQD = NoHurt
StatusAltHalved.IDDQD = NoHurt
