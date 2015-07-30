--[[
/* 
  Combat

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



Version: 15.07.27

]]

-- @USEDIR Script/Use/Combat

-- @UNDEF DEBUG_COMBAT_ACT

StartGauge = { Hero = { Default = {0,9000}, Initiative = {7000,9000}, Ambushed = {0,4000}}, Foe = { Default = {0,9000}, Ambushed = {7000,9000}, Initiative = {0,4000}} }
Act = { Hero = {}, Foe = {} }
Bestiary = Bestiary or {}
Oversoul = Oversoul or {}
Fighters = {}

function DelEnemies()
local foeid
local foedel = {}
for foeid in ICHARS() do
    if left(foeid,4) == "FOE_" then table.insert(foedel,foeid) else CSay("DelEnemies: Skipping: "..foeid) end
    end    
for _,foeid in ipairs(foedel) do 
    Console.Write("KILLING: "..foeid,255,0,0)
    RPGStat.DelChar(foeid)
    end    
end

function InitGaugeSpeed()
local ft,ftl,fli,fv
HiSpeed=1
for ft,ftl in spairs(Fighters) do --for ak=0,1 do
    for fli,fv in pairs(ftl) do -- al
        CSay("- Speed Check on ("..ft..","..fli.."):  "..RPGStat.Stat(fv.Tag,"END_Agility") )
        if RPGStat.Stat(fv.Tag,"END_Agility")>HiSpeed then HiSpeed=RPGStat.Stat(fv.Tag,"END_Agility") end
        end -- for fli
    end -- for ft
CSay("HiSpeed = "..HiSpeed)    
end 

function TargetFromAct(act)
return act.TargetGroup,act.TargetIndividual
end


function PerformAction(ft,p,fv)
-- @IF DEBUG_COMBAT_ACT
for l in each(mysplit(serialize("FIGHTER_IN_ACTION",Fighters[ft][p]),"\n")) do MINI(l); CSay(l) end 
-- @FI
(ActionFuncs[Fighters[ft][p].Act.Act] or ActionFuncs.Error)(ft,p,Fighters[ft][p].Act)
-- Reset gauge
if Fighters[ft][p].Gauge>9999 then Fighters[ft][p].Gauge = 0 end
end

function FighterTag(t,i)
return Fighters[t][i].Tag
end

function RunGauge()
local CInput = { Hero = PlayerInput, Foe = EnemyInput }
-- Do we need to input or act?
local ft,ftl,fli,fv
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        if fv.Gauge==10000 then
           return CInput[ft](fli,fv.Tag)
           end
        if fv.Gauge==20000 then return PerformAction(ft,fli,fv) end    
        end
    end
-- No input or actions, then let's move the gauge, shall we?
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        if fv.Gauge<10000 then
           fv.Gauge = fv.Gauge + ((RPGStat.Stat(fv.Tag,"END_Agility")/HiSpeed)*25)
           if fv.Gauge>10000 then fv.Gauge=10000 end
        elseif fv.Gauge>10000 then
           -- fv.Gauge = fv.Gauge + fv.Act.Speed
           fv.Gauge = fv.Gauge + Act[ft][fli].ActSpeed
           if fv.Gauge>20000 then fv.Gauge=20000 end 
           end           
        end
    end    
end


function InitCombat()
local k,v
DelEnemies()
local arena = CVVN("$COMBAT.BACKGROUND") or "TestArena.png" 
CombatData = Var2Table("COMBAT.",true)
for _,l in ipairs(mysplit(serialize("CombatData",CombatData),"\n")) do CSay("CBD> "..l) end
CombatData.BEGIN = CombatData.BEGIN or "Default" -- If Ambush or Initiative not set then the default situation will be taken ;)
Image.AssignLoad("ARENA", "GFX/Arena/"..arena)
Fighters = { Hero = {}, Foe = {} } -- Fighters.Friend = Fighters.Hero
-- Init Players
local ptag
for ak=0,2 do
    ptag = RPGChar.PartyTag(ak)
    if ptag and ptag~="" then
       Fighters.Hero[ak+1] = {
               Tag = ptag   
           }
       end      
    end
-- Reload Ammo
if skill~=3 then -- Nope, not in the hard mode. HAHA!
   for ak=0,5 do
       ptag = RPGChar.PartyTag(ak)
       if ptag and ptag~="" then
          RPGChar.Points(ptag,"AMMO").Have = RPGChar.Points(ptag,"AMMO").Maximum
          end
       end    
   end    
-- Init Enemies
local GaugeID = 48
local GiveID
local FoeCount = 0
local fx,fy 
for k,v in spairs(CombatData) do
    if left(k,3)=="FOE" and type(v)=='string' then
       FoeCount = FoeCount + 1
       if CombatData["IDFOE"..k] then GiveID=CombatData["IDFOE"..k] else GiveID=GaugeID; GaugeID=GaugeID+1 end
       InitFoeCoords(FoeCount)
       fx,fy = foec[FoeCount][1],foec[FoeCount][2]
       Fighters.Foe[FoeCount] = {
               Tag = "FOE_"..FoeCount,
               File = v,
               Level = CombatData["LV_"..k] or rand(CombatData.MINLVL,CombatData.MAXLVL),
               Letter = Str.Char(64 + FoeCount),
               x = fx,
               y = fy
           }
       LoadFoe(Fighters.Foe[FoeCount],CombatData)           
       end
    end
-- Some data for both
local k,f,i,fe
CSay("Gauge Star positions")
for k,f in spairs(Fighters) do
    for i,fe in pairs(f) do 
        CSay("Setting up start position on gauge for: "..sval(k).."::"..sval(CombatData.BEGIN))
        fe.Gauge = rand(StartGauge[k][CombatData.BEGIN][1],StartGauge[k][CombatData.BEGIN][2])
        end
    end
CSay("Gauge init pos done")    
-- General initiations    
InitGaugeSpeed()
-- Music
if CombatData.MUSIC and CombatData.MUSIC~="*NOCHANGE*" then    
   PushMusic()
   Music(CombatData.MUSIC)
   end
end


function MAIN_FLOW()
DrawScreen()
RunGauge()
Flip()
end
