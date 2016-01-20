--[[
  Confusion.lua
  Version: 16.01.20
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
-- @IF IGNOREME
StatusResistance = {}  
StatusAltAI = {}
StatusExpireOnAttack = {}
-- @FI


StatusResistance.Confusion = 'Will'

function StatusAltAI.Confusion(ch,ag,ai)
Act[ag][ai].Act = "ATK"
Act[ag][ai].ActSpeed = rand(25,450)
local timeout = 20000
local tg,ti,tmax
repeat
tmax=0
tg = ({"Hero","Foe"})[rand(1,2)]
for i,_ in pairs(Fighters[tg]) do
    if i>tmax then tmax=i end
    end
ti = rand(1,tmax)
timeout=timeout-1
if timeout<0 then Sys.Error("Confusion AI Timeout!") end -- Protection against system freezings because of infinite loops. The chance this happens is very extremely small.    
until ag~=tg and ai~=ti and Fighters[tg][ti]
Fighters[ag][ai].Gauge = 10001
if rand(1,10)==1 then
   Fighters[ag][ai].Gauge = 0
   MINI(RPGStat.GetName(ch).." is confused and totally doesn't know what to do",rand(1,255),rand(1,255),rand(1,255))
   return
   end
if ag=="Hero" and RPGStat.Points(ch,"Ammo").Maximum~=0 then
   if RPGStat.Points(ch,"Ammo").Have==0 then 
      Act.Hero[ai].Act="RLD"      
      return
      end
    Act.Hero[ai].Act="SHT"  
   end
end



StatusExpireOnAttack.Confusion = true
