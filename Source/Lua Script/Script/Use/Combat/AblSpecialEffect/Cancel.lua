--[[
  Cancel.lua
  Version: 15.11.07
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

function CancelMove(ag,ai,tg,ti,act)
local setback = {    -- How much the effect of the cancel will be depends on the difficulty setting.
                     {Foe={9000,30000, 7000}, Hero={1000, 2000,9500} },
                     {Foe={2000, 5000, 8000}, Hero={2000, 5000,8000} },
                     {Foe={1000, 1500, 9500}, Hero={9000,30000,6000} } 
                }
local tgt = Fighters[tg][ti]
CSay("- Cancel")
if tgt.Gauge<=10000 then CSay(" = Request rejected. Enemy not yet on a cancellable spot!") return end -- Cancelling only possible if the target is moving from COM to ACT
CSay("  = Group: "..tg)
CSay("  = Skill: "..skill)
local roll = rand(setback[skill][tg][1],setback[skill][tg][2])       
tgt.Gauge = 9999 - roll
if tgt.Gauge>setback[skill][tg][3] then tgt = setback[skill][tg][3] end
RepCancel(tg,ti)
CSay("  = Enemy succesfully cancelled")
return true
end


AblSpecialEffect.Cancel = CancelMove
