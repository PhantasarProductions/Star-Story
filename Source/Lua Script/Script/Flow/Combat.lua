--[[
  Combat.lua
  Version: 16.11.02
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
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

-- @USEDIR Script/Use/Combat
-- @USEDIR Script/Use/Goto

-- @UNDEF DEBUG_COMBAT_ACT

StartGauge = { Hero = { Default = {0,9000}, Initiative = {7000,9000}, Ambushed = {0,4000}}, Foe = { Default = {0,9000}, Ambushed = {7000,9000}, Initiative = {0,4000}} }
Act = { Hero = {}, Foe = {} }
Bestiary = Bestiary or {}
-- Oversoul = Oversoul or {} -- Oversoul has been dropped.
Fighters = {}
VicCheck = { YouWillNeverWin = function() return false end }
DefeatCheck = {}
FlowCheck = {}
FlawlessVictory = true
FlawlessStreak = FlawlessStreak or 0
FlawlessVictories = FlawlessVictories or 0


function TransferBestiary()
Var.D("$BESTIARYTRANSFER",serialize("ret",Bestiary))
end

function GetAch()
Ach = {
      Prefix = { Kills = "KILL", Victories = "VICTORY", Perfect = "PERFECTVICTORY", PerfectStreak = "PERFECTSTREAK" },
      BaseList = { },
   
      NumList = { }

    }
local k,p,num,numk
for k,p in spairs(Ach.Prefix) do
    Dbg("Setup Achievement set: "..k)
    Ach.BaseList[k] = GrabAchievements(p)
    for numk in each(Ach.BaseList[k]) do
        num = Sys.Val(replace(numk,p,""))
        Dbg("= Add "..numk.." >> "..num)
        Ach.NumList[p] = Ach.NumList[p] or {}
        Ach.NumList[p][num] = numk
        end
    end   
end

function NumAchAward(prefix,num)
assert(Ach.NumList[prefix],"No combat nummeric ach list named '"..prefix.."'")
local n,a
for n,a in pairs(Ach.NumList[prefix]) do
    if num>=n then Award(a) end
    end
end
    

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
        if RPGStat.CharExists(fv.Tag)==0 then
           CSay("WARNING! Character: "..fv.Tag.." does not exist")
         else
           CSay("- Speed Check on ("..ft..","..fli.."):  "..fv.Tag)
           CSay("  = Result: "..RPGStat.Stat(fv.Tag,"END_Agility") )
           if RPGStat.Stat(fv.Tag,"END_Agility")>HiSpeed then HiSpeed=RPGStat.Stat(fv.Tag,"END_Agility") end
           end
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
local allowmove,mv
local ch = FighterTag(ft,p)
allowmove=true
for st,vals in pairs(StatusBlockAction) do
    mv = ({ ['string'] = { vals }, ['table']=vals})[type(vals)]
    for blm in each(mv) do
        allowmove = allowmove and (RPGChar.ListHas(ch,"STATUSCHANGE",st)==0 or blm~=Fighters[ft][p].Act.Act) 
        end
    end
if allowmove then    
  (GameSpecificPerformAction or function() end)(ft,p,fv);
  (ActionFuncs[Fighters[ft][p].Act.Act] or ActionFuncs.Error)(ft,p,Fighters[ft][p].Act)
else
  MINI("Action cancelled!",255,180,0)
  MINI(RPGChar.GetName(Fighters[ft][p].Tag).."'s current condition does not allow that action",255,0,0)  
  end
-- Reset gauge
if Fighters[ft][p].Gauge>9999 then Fighters[ft][p].Gauge = 0 end
(GameSpecificAfterPerformAction or function() CSay("No After action") end)(ft,p,fv);
InitGaugeSpeed() -- Make sure buffs and debuffs and other crazy stuff are taken in order.
end

function FighterTag(t,i)
if not t then CSay("! WARNING ! Call to nil target group") end
if not Fighters[t] then CSay("! WARNING! Group "..t.." does not exist") return nil end
if not Fighters[t][i] then CSay("! WARNING! Fighter "..t.."["..sval(i).."] does not exist!") return nil end
return Fighters[t][i].Tag
end

function RunTimedStatusChanges()
local ch
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        if fv.Gauge==10000 then return end -- Let's hope this will not cause timed effects (like poison) during player input.
        end
     end        
for stn,stt in pairs(StatusTimed) do
   stt.CntCycles = (stt.CntCycles or stt.Cycles) - 1
   if stt.CntCycles<=0 then
      for ft,ftt in pairs(Fighters) do
          for chi,chd in pairs(ftt) do
              ch = chd.Tag
              if RPGChar.ListHas(ch,"STATUSCHANGE",stn)==1 then 
                 stt.ActionFunction(ft,chi)
                 stt.CntCycles = nil 
                 end 
              end
          end
      end
   end  
end

function RunAltAIStatus(ch,ag,ai)
for stn,stt in pairs(StatusAltAI) do
	  -- CSay(ch..">"..stn.."   => "..RPGChar.ListHas(ch,"STATUSCHANGE",stn))
    if RPGChar.ListHas(ch,"STATUSCHANGE",stn)==1 then 
       stt(ch,ag,ai)
       return true
       end
    end
return nil    
end

function RunGauge()
local CInput = { Hero = PlayerInput, Foe = EnemyInput }
-- Do we need to input or act?
local ft,ftl,fli,fv
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        if fv.Gauge==10000 and RPGChar.Points(fv.Tag,"HP").Have>0 then
           if fv.Next then
             fv.Act=fv.Next
             Act[ft][fli] = fv.Next
             fv.Next=nil
             fv.Gauge=10001
           elseif RunAltAIStatus(fv.Tag,ft,fli) then
             return true  
           else
             return CInput[ft](fli,fv.Tag)
             end
        else 
           RunTimedStatusChanges() -- Placed it here to make sure this will NOT run while players are entering their moves.
           end
        if fv.Gauge==20000 and RPGChar.Points(fv.Tag,"HP").Have>0  then return PerformAction(ft,fli,fv) end    
        end
    end
-- No input or actions, then let's move the gauge, shall we?
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        if fv.Gauge<10000 and RPGChar.Points(fv.Tag,"HP").Have>0 then
           fv.Gauge = fv.Gauge + ((RPGStat.Stat(fv.Tag,"END_Agility")/HiSpeed)*25)
           if fv.Gauge>10000 then fv.Gauge=10000 end
        elseif fv.Gauge>10000 and RPGChar.Points(fv.Tag,"HP").Have>0  then
           -- fv.Gauge = fv.Gauge + fv.Act.Speed
           fv.Gauge = fv.Gauge + Act[ft][fli].ActSpeed
           if fv.Gauge>20000 then fv.Gauge=20000 end
        elseif RPGChar.Points(fv.Tag,"HP").Have<=0 and fv.Gauge>-100 then fv.Gauge = fv.Gauge - 100     
           end           
        end
    end    
end


function InitCombat()
local k,v
BlockSwitch = {} -- If not in use this must just be an empty array or bad stuff may happen.
DelEnemies()
local arena = CVVN("$COMBAT.BACKGROUND") or "TestArena.png" 
CombatData = Var2Table("COMBAT.",true)
for _,l in ipairs(mysplit(serialize("CombatData",CombatData),"\n")) do CSay("CBD> "..l) end
CombatData.BEGIN = CombatData.BEGIN or "Default" -- If Ambush or Initiative not set then the default situation will be taken ;)
Image.AssignLoad("ARENA", "GFX/Combat/Arena/"..arena)
if CVVN("$COMBAT.ALTBACKGROUND") then AltBackGround = CVV("$COMBAT.ALTBACKGROUND") end
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
local fx,fy , fget
for k,v in spairs(CombatData) do
    if left(k,3)=="FOE" and type(v)=='string' then
       FoeCount = FoeCount + 1
       CSay('New Foe')
       CSay('Foe #'..FoeCount)
       CSay("key: "..k)
       CSay("Foe File: "..v)
       if CombatData["IDFOE"..k] then GiveID=CombatData["IDFOE"..k] else GiveID=GaugeID; GaugeID=GaugeID+1 end
       InitFoeCoords(FoeCount)
       if CombatData["ALTCOORDSFOE"..right(k,len(k)-3)] then
          fget = loadstring("return "..CombatData["ALTCOORDSFOE"..right(k,len(k)-3)])
          foec[FoeCount][1],foec[FoeCount][2] = fget()
          end
       fx,fy = foec[FoeCount][1],foec[FoeCount][2]
       Fighters.Foe[FoeCount] = {
               Tag = "FOE_"..FoeCount,
               File = v,
               Level = CombatData["LVFOE"..right(k,len(k)-3)] or rand(CombatData.MINLVL,CombatData.MAXLVL),
               Letter = Str.Char(64 + FoeCount),
               x = fx,
               y = fy
           }
       LoadFoe(Fighters.Foe[FoeCount],CombatData)           
       end
    end
-- Alternate enemy initiation
if CombatData.AltEnemyBuild then
   CSay("Trying to execute alternate enemy build: "..CombatData.AltEnemyBuild)
   MS.Run("COMBAT",CombatData.AltEnemyBuild) 
   end    
-- Switch blocking
if CombatData.NOSWITCH then BlockSwitch = mysplit(CombatData.NOSWITCH,";") end   
-- Gauge Init
local k,f,i,fe
CSay("Gauge Star positions")
for k,f in spairs(Fighters) do
    for i,fe in pairs(f) do 
        CSay("Setting up start position on gauge for: "..sval(k).."::"..sval(CombatData.BEGIN))
        fe.Gauge = rand(StartGauge[k][CombatData.BEGIN][1],StartGauge[k][CombatData.BEGIN][2])
        end
    end
-- Init status changes and reset stat boosts
CSay("Status and stat resets")
for chid in ICHARS() do
        RPGChar.CreateList(chid,"STATUSCHANGE") -- Yeah, status changes from previous fight do not count!
        CSay("= "..chid.." now has the list: STATUSCHANGE")
        end         
CSay("Gauge init pos done")    
-- General initiations    
InitGaugeSpeed()
-- Grab all achievements we need
GetAch()
-- Music
if CombatData.MUSIC and CombatData.MUSIC~="" and CombatData.MUSIC~="*NOCHANGE*" then    
   PushMusic()
   CSay("Music! "..sval(CombatData.MUSIC))
   Music(CombatData.MUSIC)
   end
end

function iStatusChange(ch) -- A quick iterator for status changes.
local i=-1
return function()
       i = i + 1
       if i<RPGStat.CountList(ch,"STATUSCHANGE") then return RPGStat.ListItem(ch,"STATUSCHANGE",i+1) end
       return nil
       end
end

function DefaultVictory()
local i,v
for i,v in pairs(Fighters.Foe) do 
    if RPGChar.Points(v.Tag,"HP").Have>0 then return false end 
    end -- Return false only gets executed if an enemy exists, if it doesn't exist we got an entirely empty "for" loop as 'return false' will be called for zero times.
return true
end

function DefaultDefeated()
local i,v
for i,v in pairs(Fighters.Hero) do 
    if RPGChar.Points(v.Tag,"HP").Have>0 then return false end 
    end
return true    
end
   
function Victory()
return (VicCheck[CombatData.VICTORYCHECK] or DefaultVictory)()
end

function Defeated()
return (DefeatCheck[CombatData.DEFEATEDCHECK] or DefaultDefeated)()
end



function MAIN_FLOW()
DrawScreen()
for f in each(FlowCheck) do f() end
if Defeated() then RunDefeated() elseif Victory() then RunVictory() else RunGauge() end
Flip()
LAURA.TerminateBye()
end
