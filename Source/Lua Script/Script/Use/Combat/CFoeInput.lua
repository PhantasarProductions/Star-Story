--[[
  CFoeInput.lua
  Version: 15.12.10
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
FoeTargetSelector = {

  ["1A"] = function(me)
           local t = rand(1,9)
           local myhero = Fighters.Foe[t]
           if not myhero then return false,false end
           local mytag = myhero.Tag
           if RPGStat.Points(mytag,"HP").Have==0 and (not allowdead) then return false,false end
           return "Foe",t
           end,
  ["1F"] = function(me,allowdead)
           local t = rand(1,3)
           local myhero = Fighters.Hero[t]
           if not myhero then return false,false end
           local mytag = myhero.Tag
           if RPGStat.Points(mytag,"HP").Have==0 and (not allowdead) then return false,false end
           return "Hero",t
           end,
  ["AA"] = function(me)
           return "Foe",true
           end,
  ["AF"] = function(me)
           return "Hero",true
           end,
  ["OS"] = function(me)
           local i,v
           for i,v in pairs(Fighters.Foe) do
               if v==me then return "Foe",i end
               end
           Sys.Error("FoeTargetSelector.OS: Cannot find myself")    
           end,                  
  ["EV"] = function(me) 
           return true,true -- The EV setting ignores everything anyway, as everybody in combat, friend or foe alike will get hit by the selected move.
           end           
}


function EnemyInput(pos,tag)
-- Fighters.Foe[pos].Gauge = 0 -- Original line to prevent crashes when the enemies were still in "IDLE" mode as I was first testing the player moves.
local myfoe=Fighters.Foe[pos];
(Foe_AI[myfoe.AI] or function() Sys.Error("Unknown enemy AI setup: "..sval(myfoe.AI)) end)(pos)
Fighters.Foe[pos].Act = Act.Foe[pos]
end
