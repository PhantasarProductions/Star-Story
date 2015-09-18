--[[
  CAction.lua
  Version: 15.09.18
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

function CheckTarget(tg,ti,allowdead)
local ret = true
local fd = Fighters[tg][ti]
ret = ret and fd
ret = ret and RPGChar.CharExists(fd.Tag)
ret = ret and (allowdead or RPGChar.Points(fd.Tag,"HP").Have>0)
return ret
end

function AblEffect(ag,ai,act,tg,ti)
local abl=act.Item
local atkdata
local cha = FighterTag(ag,ai)..""
local cht = FighterTag(tg,ti).."" -- This way of forming FORCES a <nil> value error if this should happen. I need to know if the evil's done here or not :)
-- Cure status changes (this must always be the first thing to do)
-- Heal absolute or by percent
if abl.Healing and abl.Healing>0 then
   (({ Absolute = function() Heal(tg,ti,abl.Healing) end,
      Percent  = function()
                 local hpt = RPGChar.Points(cht,"HP")
                 local hpm = hpt.Maximum
                 local points = (hpm/100)*abl.Healing
                 Heal(tg,ti,points)
                 end
   })[abl.HealingType] or function() Sys.Error("Unknown healing type: "..sval(abl.HealingType)) end )()               
   end
-- Hurt target (can also heal if the element is being absored)
if abl.AttackPower and abl.AttackPower>0 then
   atkdata = {
       atk = abl.AttackStat,
       def = abl.DefenseStat,
       mod = abl.AttackPower/100,
       element
           = abl.AttackElement
      }
   Attack(ag,ai,act,atkdata)   
   end
-- Scripted stuff
-- Cause status changes (this must always be the last thing to do)
end; AbilityEffect = AblEffect

ActionFuncs = {}

function ActionFuncs.Error(g,i,act)
Sys.Error("Unknown Action Tag: "..sval(act.Act))
end

function ActionFuncs.SHT(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
if RPGChar.Points(ch,"AMMO",1).Have<=0 then return MINI(RPGChar.Name(ch).." cannot shoot! Out of ammo!") end
local tg,ti = TargetFromAct(act)
if not CheckTarget(tg,ti) then MINI("Shot cancelled",255,0,0); MINI("There's no enemy on that spot anymore",255,180,0); return end
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." shoots")
-- Animate character 
SpriteAnim[ag](ai,act)
-- SpellAni for the projectile
RPGChar.NewData(ch,"ShootSpellAni","PhotonGun") -- If not properly set, we'll assume the photon gun animation is required. 
SpellAni[RPGChar.GetData(ch,"ShootSpellAni")](ag,ai,tg,ti)
-- Perform Attack
Attack(ag,ai,act)
-- Remove one bullet
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO",1).Have - 1
end


function ActionFuncs.RLD(ag,ai,act)
SFX("Audio/SFX/Gun-Cocking-Sound.ogg")
if ag~="Hero" then Sys.Error("Reloading can only be done by heroes") end
local t = FighterTag(ag,ai)
local h = {UniWendicka="her",UniCrystal="her"}
RPGChar.Points(t,"AMMO").Have = RPGChar.Points(t,"AMMO").Maximum
MINI( RPGChar.GetName(t) .. " has reloaded "..(h[t] or "his").." gun")
end 


function ActionFuncs.ATK(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
local tg,ti = TargetFromAct(act)
if not CheckTarget(tg,ti) then MINI("Attack cancelled",255,0,0); MINI("There's no enemy on that spot anymore",255,180,0); return end
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." attacks")
-- Animate character 
SpriteAnim[ag](ai,act)
-- Perform Attack
Attack(ag,ai,act)
end

function ActionFuncs.EAI(ag,ai,act)
if not act.EAI then Sys.Error("Illegally set up act for EAI") end
NewMessage(act.Item.Name,ItemIconCode(act.ItemCode))
SpriteAnim[ag](ai,act)
local ch = FighterTag(ag,ai)
local tg,ti
local function SingleEffect(ag,ai,act) AbilityEffect(ag,ai,act,act.TargetGroup,act.TargetIndividual) end
local function GroupEffect(ag,ai,act)
               local i
               local tg = act.TargetGroup
               for i,_ in pairs(Fighters[tg]) do AbilityEffect(ag,ai,act,tg,i) end
               end
(({
      ["1F"] = SingleEffect,
      ["1A"] = SingleEffect,
      ["OS"] = SingleEffect,
      ["AA"] = GroupEffect,
      ["AF"] = GroupEffect,
      ["EV"] = function(ag,ai,act)
               local tg,ti,group
               for tg,group in pairs(Fighters) do for ti,_ in pairs(group) do AbilityEffect(ag,ai,act,tg,ti) end end
               end
      })[act.Item.Target] or function() Sys.Error("EAI: Unknown target type"..act.Item.Target) end)(ag,ai,act)
end

function ActionFuncs.ITM(ag,ai,act)
if ag=="Foe" then -- Foes should use "FAI" in stead.
   MINI("Action skipped! Enemies cannot use items",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did)",255,0,0)
   return
   end
local ch = FighterTag(ag,ai)   
if RPGChar.Stat(ch,"INVAMNT"..act.ItemSocket)<=0 then
   MINI("Action Cancelled!",255,0,0)
   MINI("Item socket empty",255,180,0)
   return
   end
RPGChar.DecStat(ch,"INVAMNT"..act.ItemSocket)   
act.EAI = true
ActionFuncs.EAI(ag,ai,act)
end   

function ActionFuncs.LRN(ag,ai,act)
if ag=="Foe" then -- Foes should use "FAI" in stead.
   MINI("Action skipped! Enemies cannot use player abilities",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did)",255,0,0)
   return
   end
local ch = FighterTag(ag,ai)
local lrncode = RPGChar.ListItem(ch,"LEARN",1)
act.ItemCode="ABL_"..lrncode
act.Item = ItemGet(act.ItemCode)
;(({  ["1A"] = function() act.TargetGroup="Hero"; act.TargetIndividual=ai end,
      ["AA"] = function() act.TargetGroup="Hero"; end,
      ["OS"] = function() act.TargetGroup="Hero"; act.TargetIndividual=ai end})[act.Item.Target] or function() end)()  
act.EAI = true
(XCharAbility[ch] or function() end)()
MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
MS.Run("BOXTEXT","RemoveData","NEWABILITY")
MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
SerialBoxText("NEWABILITY","NEWABILITY."..upper(ch),"Combat")
ActionFuncs.EAI(ag,ai,act)
RPGChar.RemList(ch,"LEARN",lrncode)
RPGChar.AddList(ch,"ABL",lrncode)
MINI(RPGChar.GetName(ch).." learned '"..act.Item.Name.."'",180,0,255)
end   


function ActionFuncs.ABL(ag,ai,act)
if ag=="Foe" then -- Foes should use "FAI" in stead.
   MINI("Action skipped! Enemies cannot use player abilities",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did)",255,0,0)
   return
   end
local ablshort = right(act.ItemCode,len(act.ItemCode)-4)   
local ch = FighterTag(ag,ai)   
local ap = RPGChar.Points(ch,"AP")
local pu,puu,r
local pufullnames = { INSTANT = "Instant Execution", CANCEL = "Cancel move", DBLSPEED = "Double speed", DBLPWR="Double Power",APCUT="Half AP Cost" }
local APCost = act.Item.ABL_AP
if RPGChar.ListHas(ch,"ABL_POWERUP",ablshort..".APCUT")~=0 then APCost = math.ceil(APCost/2) end
if ap.Have<APCost then MINI("Action cancelled",255,0,0); MINI(RPGChar.GetName(ch).." does not have enough AP!",255,180,0) return end
ap.Dec(APCost)  
act.EAI = true
(XCharAbility[ch] or function() end)()
ActionFuncs.EAI(ag,ai,act)
local uch = ch
if uch=="UniWendicka" then uch="Wendicka" end
-- Award powerups
inc("%ABL.USED."..upper(uch).."."..upper(act.ItemCode))
local groundvar = CVV("%ABL.USED."..upper(uch).."."..upper(act.ItemCode)) + RPGChar.Stat(ch,"Level")
for pu in each(ABL_PowerUps) do
    puu = upper(pu)
    CSay("Checking: ABL_"..pu.."; Item:"..sval(act.Item['ABL_'..pu]).."; List has: "..RPGChar.ListHas(ch,"ABL_POWERUP",ablshort.."."..puu))
    if act.Item["ABL_"..pu] and RPGChar.ListHas(ch,"ABL_POWERUP",ablshort.."."..puu)==0 then 
       r = rand(0,act.Item["ABL_"..pu])
       CSay("We rolled "..r.." for "..pu.."; It must be lower than "..groundvar)
       if r<groundvar then 
          RPGChar.AddList(ch,"ABL_POWERUP",ablshort.."."..puu)
          MINI(RPGChar.GetName(ch).." earned powerup '"..pufullnames[puu].."' on '"..act.Item.Name.."'",180,0,255)          
          end
       end
    end
end   


function ActionFuncs.FAI(ag,ai,act)
if ag=="Hero" then -- Heroes should use ITM, ABL or ARM in stead.
   MINI("Action skipped! FAI is an enemy-only setting, not the playable characters!",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did",255,0,0)
   return
   end
act.EAI = true
ActionFuncs.EAI(ag,ai,act)
end
