--[[
  CHurt.lua
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

-- @UNDEF DEBUG_HURT

function Hurt(tg,ti,hp,element)
local r,g,b = 255,255,255
local report = round(hp)
local dodmg = round(hp)
local chtarget = FighterTag(tg,ti)
local jack = CVV("&CHEAT.JACK")
local god  = CVV("&CHEAT.GOD")
if RPGChar.StatExists(chtarget,"ER_Healing")==0 then RPGChar.DefStat(chtarget,"ER_Healing",6) end
local elementalresistance = ({
                                 [1] = function() return RPGStat.Stat(chtarget,"ER_"..element) end,
                                 [0] = function() return 3 end
                              })[RPGStat.StatExists(chtarget,"ER_"..(element or "Non-Elemental"))]();
if RPGStat.GetData(Fighters[tg][ti].Tag,"IMMUNE")=="YES" then elementalresistance=5 end                              
-- @IF DEBUG_HURT
   CSay("HURT: Received data "..tg..","..ti..","..hp..","..(element or "Non-Elemental"))
   CSay("HURT: Resistance is "..elementalresistance);
-- @FI                                                            
(({   -- Lua way of doing a 'switch case' statment. Ugly I know, but it works. :-P
      -- (In this case ";" must be behind the last command. One of the few cases where Lua requires the use of ";". That is only the case if the last command before this ends with a ")")     
                 [0] = function() -- fatal
                       report = "DEATH"; r,g,b = 255,0,0
                       dodmg = RPGStat.Points(chtarget,"HP").Have
                       end,
                 [1] = function() -- super weakness
                       dodmg = dodmg * 4
                       report = dodmg; r,g,b = 255,0,0
                       end,
                 [2] = function() -- regular weakness
                       dodmg = round(dodmg * 1.75)       
                       report = dodmg; r,g,b = 255,80,0
                       end,
                 [4] = function() -- half
                       dodmg = round(dodmg/2)
                       if dodmg<1 then dodmg=1 end
                       report = dodmg
                       r,g,b = 255,180,0
                       end,      
                 [5] = function() -- resistent
                       dodmg = 0
                       report = "NO EFFECT!"      
                       r,g,b = 255,180,0
                       end,
                 [6] = function()
                       if RPGChar.Points(chtarget,"HP").Have == 0 then
                          dodmg = 0
                          report = "NO EFFECT!"      
                          r,g,b = 255,180,0
                          return
                          end
                       dodmg = math.abs(dodmg)*(-1)
                       report = math.abs(dodmg)
                       r,g,b = 0,255,0
                       for status in iStatusChange(chtarget) do
                           if StatusAltHealing[status] then dodmg,report,r,g,b = StatusAltHealing[status](chtarget,dodmg,element) end
                           end
                       end,      
                 default = function() end      -- In all other situations (which includes situation 3) do nothing :)
               })[elementalresistance] or function() end)()
FlawlessVictory = FlawlessVictory and (not(tg=="Hero" and dodmg>0 and elementalresistance<5))
if god and tg=="Hero" and elementalresistance<5 then dodmg = 0 end
if jack and tg=="Foe" and elementalresistance<6 then dodmg = RPGStat.Points(chtarget,"HP").Have end
RPGStat.Points(chtarget,"HP").Have = RPGStat.Points(chtarget,"HP").Have - dodmg
if tg=="Hero" and RPGChar.Points(chtarget,"HP").Have>0 then UpPoint(i) end --RPGChar.Points(chtarget,"AP").Have = RPGChar.Points(chtarget,"AP").Have + 1 end 
CharReport(tg,ti,report,{r,g,b})               
if RPGChar.Points(chtarget,"HP").Have==0 then RPGChar.ClearList(chtarget,"STATUSCHANGE") end -- Remove all statuschanges when you die.
end

function Heal(tg,ti,hp)
Hurt ( tg , ti , hp , "Healing")
end


function Attack(ag,ai,act,pdata,ptg,pti)
local chactor = FighterTag(ag,ai)
local data = pdata or {}
local tg,ti = ptg,pti 
CSay("tg = "..sval(tg).."; ti = "..sval(ti))
if not(tg and ti) then tg,ti = TargetFromAct(act) end
local chtarget = FighterTag(tg,ti)
local atkstat = data.atk or "Strength"
local defstat = data.def or "Defense"
local modifier = data.mod or 1
local critical = ({[true]=1,[false]=0})[data.critical==true] -- I have to do it this way, as 'nil' can be a value and would result into a crash.
local element = data.element or "Non-Elemental"
local atk = RPGStat.Stat(chactor,"END_"..atkstat) * modifier
local def = RPGStat.Stat(chtarget,"END_"..defstat)                              
local damage = atk + rand(0,round(atk*.75))
local defense = def + rand(0,round(def*.25))
if data.ignoredefense then defense=0 end
local totaldamage = damage - defense
if totaldamage<1 then totaldamage=1 end
Hurt(tg,ti,totaldamage,element)                               
end
