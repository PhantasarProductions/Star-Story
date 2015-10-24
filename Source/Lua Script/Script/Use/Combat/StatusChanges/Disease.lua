--[[
  Disease.lua
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
-- @IF IGNOREME
-- These lines are only meant to "fool" the outline routine in Eclipse ;)
-- The @IF IGNOREME and @FI command will make GALE ignore these lines. :)
StatusResistance = {}
StatusAltStat = {}
StatusDrawFighter = {}
-- @FI


StatusResistance.Disease = Disease



function StatusDrawFighter.Disease(g,i)
local bx,by = FighterCoords(g,i)
local wy = by - 16
local wx = bx
local x,y
x = wx + (math.sin(Time.MSecs()/1000)*20)
y = wy + (math.cos(Time.MSecs()/1000)*5)
Image.LoadNew(RodeKruis,'GFX/Combat/StatusAni/Diseased/Rode Kruis.png'); Image.HotCenter(RodeKruis)
Image.Show(RodeKruis,x,y)
end


StatusAltStat.Disease = {}
function StatusAltStat.Disease.HP(ch)
RPGChar.DefStat(ch,'HP',RPGChar.Points(ch,"HP").Have) -- This will make the Max HP always match the current HP as long as this status lasts, and due to that healing becomes impossible as long as this status lasts.
end
