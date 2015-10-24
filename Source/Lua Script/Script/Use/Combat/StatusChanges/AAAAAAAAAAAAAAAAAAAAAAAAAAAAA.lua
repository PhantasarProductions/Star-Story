--[[
  AAAAAAAAAAAAAAAAAAAAAAAAAAAAA.lua
  Version: 15.10.24
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

skill = Sys.Val(Var.C('%SKILL')) -- Seems this is needed or the skill value won't reach the status changes.


StatusResistance = {}     -- Each status needs the name of the resistance that will be used to block this status change. If none were given, no resistance exists against it.
StatusTimed = {}          -- Each status needs an array with the next fields { Cycles:int, ActionFunction(g,i) }. CntCycles will be used by the fight routines itself to keep track of the number of cycles,
StatusBlockAction = {}    -- Each status needs an array containing a list of all types of actions to be blocked like ATK or SHT or ABL etc. 
StatusAltGauge = {}       -- Each status needs a function containing the alternate action
StatusAltStat = {}        -- Block a stat to a certain value. Each status needs a table with a function(ch) value per affected stat.
StatusDrawFighter = {}    -- Each status should contain a function (g,i) telling the DrawFighters routine what to do to indicate to the player something is wrong.



function PerformAltStat(ch,stat)
if right(Time.MSecs(),2)=='00' then -- Does this speed things up a little?
   for s in iStatusChange(ch) do
	     -- CSay(ch.." has "..s) -- Debug line
       if StatusAltStat[s] and StatusAltStat[s][stat] then StatusAltStat[s][stat](ch) end
       end
   end    
end
