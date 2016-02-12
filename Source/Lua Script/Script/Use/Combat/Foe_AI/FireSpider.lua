--[[
  FireSpider.lua
  Version: 16.02.12
  Copyright (C) 2016 Jeroen Petrus Broks
  
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
Foe_AI = {}  -- Ignored, but this fools my Outliner in Eclipse ;)
-- @FI




function Foe_AI.FireSpider(pos)
local me = Fighters.Foe[pos].Tag
RPGChar.IncStat(me,"BASE_Strength",rand(0,RPGChar.Stat(me,'BASE_Strength')))
RPGChar.IncStat(me,"BASE_Will",rand(0,RPGChar.Stat(me,'BASE_Will')))
RPGChar.IncStat(me,"BASE_Accuracy",rand(0,RPGChar.Stat(me,'BASE_Accuracy')))
Mini ( RPGChar.GetName(me) .. " is gathering extra power" , rand(200,255),rand(150,180),0)
if RPGChar.Stat(me,'BASE_Strength')>1000000 then RPGChar.DefStat(me,'BASE_Strength') end
if RPGChar.Stat(me,'BASE_Will')>1000000 then RPGChar.DefStat(me,'BASE_Strength') end
if RPGChar.Stat(me,'BASE_Accuracy')>1000000 then RPGChar.DefStat(me,'BASE_Strength') end
return Foe_AI.Default(pos)
end
