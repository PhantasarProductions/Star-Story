--[[
  CAction.lua
  Version: 16.05.26
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

function PerformSpellAni(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
local tg,ti = TargetFromAct(act)
local item = act.Item
if not item.SpellAni_Reference then return end
White();
({[true] = function()
           local ref = item.SpellAni_Reference
           if not suffixed(upper(ref),".LUA") then ref = ref .. ".lua" end
           MS.Load("SPELLANI","Script/External/SpellAni/"..ref)
           local parameters = ag..";"..ai..";"..tg..";"..sval(ti)
           if item.SpellAni_Parameters then parameters = parameters .. ";"..item.SpellAniParameters end
           MS.Run("SPELLANI","SPELLANI",parameters)
           MS.Destroy("SPELLANI")
           end,
 [false] = function()
           if item.SpellAni_Reference=="" then CSay("No SpellAni for this ability or so it seems."); return end
           (SpellAni[item.SpellAni_Reference] or function() MINI("WARNING! Spellani "..item.SpellAni_Reference.." does not exist") MINI("This is the result of a bug, please report it!") end)(ag,ai,tg,ti,item.SpellAni_Parameters)  
           end})[item.SpellAni_External==true]() 
end

function CheckTarget(tg,ti,allowdead)
local ret = true
local fd = Fighters[tg][ti]
ret = ret and fd
ret = ret and RPGChar.CharExists(fd.Tag)
ret = ret and (allowdead or RPGChar.Points(fd.Tag,"HP").Have>0)
return ret
end

function Miss(tg,ti)
CharReport(tg,ti,"Miss",{0,180,255})
end   

function RepCancel(tg,ti)
CharReport(tg,ti,"Cancel",{255,40,10})
end   

function AccuracyEvasion(ag,ai,tg,ti)
local ach = Fighters[ag][ai].Tag
local tch = Fighters[tg][ti].Tag
local acc = RPGStat.Stat(ach,"END_Accuracy")
local eva = RPGStat.Stat(tch,"END_Evasion")
local hit = rand(0,acc) -- acc + rand(1,math.ceil(acc*.75))
local ddg = rand(1,eva) -- eva - rand(1,math.ceil(eva*.25))
return ddg>hit
end

function ChargeAbility(ag,ai,act)
local now  = act.Item
local next = ItemGet(act.Item.UserNextMove)
if now.Target ~= next.Target then Sys.Error("Charge up move target mismatch!") end -- The Target setting for both moves MUST be the same 
local nextmove = { Item = next, TargetGroup = act.TargetGroup, TargetIndividual = act.TargetIndividual, Act = 'CAI', ItemCode = act.Item.UserNextMove, ActSpeed = next.ActSpeed  }
Fighters[ag][ai].Next = nextmove
CharReport(ag,ai,"Charged",{90,122,118})
CSay(Fighters[ag][ai].Tag.." will perform "..nextmove.ItemCode.." in the next turn")
Fighters[ag][ai].Pick="Default"      
end

function AblEffect(ag,ai,act,tg,ti)
local armd100 = rand(1,100)
if act.HitPercentage and armd100>act.HitPercentage then
   CSay("ARM Missed due to high roll") 
   Miss(tg,ti) 
   return
   end
local effect
local abl=act.Item
local atkdata
local cha = FighterTag(ag,ai)..""
local cht = FighterTag(tg,ti) --.."" -- This way of forming FORCES a <nil> value error if this should happen. I need to know if the evil's done here or not :)
if not cht then return end -- The bug mentioned earlier was already fixed, and this can prevent enemies trying to heal their allies crashing the game if the player actually killed them before the enemy could do this.
-- Cure death if asked or miss if not asked and the character is dead. (Must come first)
if     RPGChar.Points(cht,"HP").Have==0 and abl.CureDeathOne  then RPGChar.Points(cht,"HP").Have=1; CharReport(tg,ti,"Revive",{180,255,0}); effect=true
elseif RPGChar.Points(cht,"HP").Have==0 and abl.CureDeathFull then RPGChar.Points(cht,"HP").Have=RPGChar.Points(cht,"HP").Maximum; CharReport(tg,ti,"Resurrect",{180,255,0}); effect=true
elseif RPGChar.Points(cht,"HP").Have==0 then Miss(tg,ti); return end     
-- Cure status changes (this must always be the first thing to do after raising death spells)
local cured,stc
for i,y in spairs(abl) do
    if prefixed(i,'Cure') and y then
       stc = right(i,len(i)-len('Cure'))
       cured = RPGChar.ListHas(cht,"STATUSCHANGE",stc)~=0
       if cured then 
          CSay("Curing "..stc.." on "..cht)
          RPGChar.RemList(cht,"STATUSCHANGE",stc)
          CharReport(tg,ti,"Cure",{180,255,0})
          effect=true
          end
       end
    end
-- Heal absolute or by percent
if abl.Healing and abl.Healing>0 then
   (({ Absolute = function() Heal(tg,ti,abl.Healing); effect=true end,
      Percent  = function()
                 local hpt = RPGChar.Points(cht,"HP")
                 local hpm = hpt.Maximum
                 local points = (hpm/100)*abl.Healing
                 Heal(tg,ti,points)
                 effect=true
                 end
   })[abl.HealingType] or function() Sys.Error("Unknown healing type: "..sval(abl.HealingType)) end )()               
   end
-- Recover AP absolute or by percent
if abl.APRecover and abl.APRecover>0 then
   (({ Absolute = function() HealAP(tg,ti,abl.APRecover); effect=true end,
      Percent  = function()
                 local hpt = RPGChar.Points(cht,"AP")
                 local hpm = hpt.Maximum
                 local points = (hpm/100)*abl.APReciver
                 HealAP(tg,ti,points)
                 effect=true
                 end
   })[abl.APReciver] or function() Sys.Error("Unknown APRecover Type: "..sval(abl.HealingType)) end )()               
   end
-- Hurt target (can also heal if the element is being absored)
if abl.AttackPower and abl.AttackPower>0 then
   atkdata = {
       atk = abl.AttackStat,
       def = abl.DefenseStat,
       mod = (abl.AttackPower + (act.XPower or 0)) / 100,
       element
           = abl.AttackElement
      }
   if act.DoublePower then atkdata.mod = atkdata.mod * 2 end   
   Attack(ag,ai,act,atkdata,tg,ti)   
   effect=true
   end
-- Buff or debuff
for k,v in pairs(abl) do
    if prefixed(k,"Buff_") then
       local tk = replace(k,"Buff","")
       local bf = RPGStat.Stat(cht,"BUFF_"..tk)
       local tv = round(RPGStat.Stat(cht,"BASE_"..tk)*(v/100))
       if (tv<0 and bf>tv) or (tv>0 and bf<tv) then 
          CharReport(tg,ti,tk.." "..v.."%",{255,255,0})
          RPGStat.DefStat(cht,"BUFF_"..tk,tv)
       end   
    end
end   
-- Scripted stuff
if abl.ScriptEffect_Reference and abl.ScriptEffect_Reference~="" then
   if abl.ScriptEffect_External then
      MS.Load("COMBAT_ABLEFFECT","Script/Combat/Effect/"..abl.ScriptEffect_Reference)
      MS.Run("COMBAT_ABLEFFECT","SCRIPTEFFECT",ag..";"..ai..";"..tg..";"..ti)
      effect = effect or CVV("&RET")
      else
      effect = AblSpecialEffect[abl.ScriptEffect_Reference](ag,ai,tg,ti,act,abl.ScriptEffect_Parameters) or effect
      end 
   end
-- Cancel powerup
if act.Cancel then CancelMove(ag,ai,tg,ti,act) end   
-- Cause status changes (this must always be the last thing to do)
local stcr
for i,y in spairs(abl) do
    if prefixed(i,'Cause') and y then
       stc = right(i,len(i)-len('Cause'))
       stcr = StatusResistance[stc] or stc
       if RPGChar.ListHas(cht,stc)==0 and (RPGChar.StatExists(cht,"SR_TRUE_"..stcr)==0 or rand(1,100)>RPGStat.Stat(cht,"SR_TRUE_"..stcr)) then
          RPGChar.AddList(cht,"STATUSCHANGE",stc)
          CharReport(tg,ti,stc,{255,255,255})               
          effect=true
          end
       end
    end
-- If nothing happened along the way display "Miss"
if not effect then Miss(tg,ti) end
end; AbilityEffect = AblEffect

ActionFuncs = {}

function ActionFuncs.Error(g,i,act)
Sys.Error("Unknown Action Tag: "..sval(act.Act))
end

function ActionFuncs.SHT(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
if RPGChar.Points(ch,"AMMO",1).Have<=0 then return MINI(RPGChar.GetName(ch).." cannot shoot! Out of ammo!") end
local tg,ti = TargetFromAct(act)
if not CheckTarget(tg,ti) then MINI("Shot cancelled",255,0,0); MINI("There's no enemy on that spot anymore",255,180,0); return end
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." shoots")
-- Animate character 
SpriteAnim[ag](ai,act)
-- SpellAni for the projectile
White()
RPGChar.NewData(ch,"ShootSpellAni","PhotonGun") -- If not properly set, we'll assume the photon gun animation is required. 
SpellAni[RPGChar.GetData(ch,"ShootSpellAni")](ag,ai,tg,ti)
-- Perform Attack
Attack(ag,ai,act)
-- Remove one bullet
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO",1).Have - 1
Fighters[ag][ai].Pick="Default"
end


function ActionFuncs.RLD(ag,ai,act)
SpriteAnim[ag](ai,act)
SFX("Audio/SFX/Gun-Cocking-Sound.ogg")
if ag~="Hero" then Sys.Error("Reloading can only be done by heroes") end
local t = FighterTag(ag,ai)
local h = {UniWendicka="her",UniCrystal="her"}
RPGChar.Points(t,"AMMO").Have = RPGChar.Points(t,"AMMO").Maximum
MINI( RPGChar.GetName(t) .. " has reloaded "..(h[t] or "his").." gun")
Fighters[ag][ai].Pick="Default"
end 


function ActionFuncs.ATK(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
local tg,ti = TargetFromAct(act)
if not CheckTarget(tg,ti) then MINI("Attack cancelled",255,0,0); MINI("There's no enemy on that spot anymore",255,180,0); return end
if tg=="Hero" then
   if (XCharAttacked[Fighters.Hero[ti].Tag] or function(ag,ai) end)(ag,ai) then
      RepCancel(ag,ai) 
      Fighters[ag][ai].Gauge = -rand(0,4000-(skill*1000))
      return 
      end -- If "true" is returned it means the playable character cancelled the attack!
   end
if ag=="Hero" then
   if (XCharAlternateAttack[Fighters.Hero[ai].Tag] or function(ai,ti,tg) end)(ai,ti,tg) then return end
   end
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." attacks")
-- Animate character 
SpriteAnim[ag](ai,act)
-- Perform Attack
if AccuracyEvasion(ag,ai,tg,ti) then
   Miss(tg,ti)
   else
   Attack(ag,ai,act)
   end
-- Reset character sprit
Fighters[ag][ai].Pick="Default"      
end

function ActionFuncs.GRD(ag,ai,act)
Fighters[ag][ai].Gauge = ({Hero = 9999 - (1234*skill), Foe = 9999 - (1234*(4-skill) )})[ag]
end

function ActionFuncs.EAI(ag,ai,act)
if not act.EAI then Sys.Error("Illegally set up act for EAI") end
NewMessage(act.Item.Name,ItemIconCode(act.ItemCode))
SpriteAnim[ag](ai,act)
PerformSpellAni(ag,ai,act)
if act.Item.UserNextMove and act.Item.UserNextMove~="" then 
   ChargeAbility(ag,ai,act)
   return 
   end
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
Fighters[ag][ai].Pick="Default"      
end

function ActionFuncs.CAI(ag,ai,act)
act.EAI = true
ActionFuncs.EAI(ag,ai,act)
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
if act.Item.ItemType == "Consumable" then RPGChar.DecStat(ch,"INVAMNT"..act.ItemSocket) end
if act.Item.ItemType ~= "Consumable" and act.Item.ItemType ~= "EndlesslyUsable" then 
   MINI("Action Cancelled!",255,0,0)
   MINI("Item cannot be used this way!",255,180,0)
   return
   end
if not act.Item.UseCombat then 
   MINI("Action Cancelled!",255,0,0)
   MINI("That item cannot be used in combat!",255,180,0)
   return
   end
EquipEffect(ch)   
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
MINI(RPGChar.GetName(ch).." learned '"..Var.S(act.Item.Name).."'",180,0,255)
RPGChar.Points(ch,"EXP").inc(round(2000/skill))
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
local pufullnames = { INSTANT = "Instant Execution", CANCEL = "Cancel move", DBLSPEED = "Double speed", DBLPWR="Double Power", DBLPOWER="Double Power", APCUT="Half AP Cost" }
local APCost = act.Item.ABL_AP
if RPGChar.ListHas(ch,"ABL_POWERUP",ablshort..".APCUT")~=0 then APCost = math.ceil(APCost/2) end
if not CVV("&CHEAT.MERLIN") then
   if ap.Have<APCost then MINI("Action cancelled",255,0,0); MINI(RPGChar.GetName(ch).." does not have enough AP!",255,180,0) return end
   ap.Dec(APCost)  
   end        
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
          MINI(RPGChar.GetName(ch).." earned powerup '"..pufullnames[puu].."' on '"..Var.S(act.Item.Name).."'",180,0,255)          
          end
       end
    end
end   

function ActionFuncs.ARM(ag,ai,act)
if ag=="Foe" then -- Foes should use "FAI" in stead.
   MINI("Action skipped! Enemies cannot use ARMs",255,0,0)
   MINI("This must be the result of a bug",255,0,0)
   MINI("Please write an issue about it on",255,0,0)
   MINI("https://github.com/Tricky1975/Star-Story/issues",0,180,255)
   MINI("(Unless somebody already did)",255,0,0)
   return
   end
local ablshort = right(act.ItemCode,len(act.ItemCode)-4)   
local ch = FighterTag(ag,ai)   
local ap = RPGChar.Points(ch,"ARM.AMMO."..ablshort)
if not CVV("&CHEAT.RAMBO") then
	if ap.Have<1 then MINI("Action cancelled",255,0,0); MINI(RPGChar.GetName(ch).."'s ARM is out of ammo!",255,180,0) return end
	ap.Dec(1)
	end
act.EAI = true
(XCharAbility[ch] or function() end)()
ActionFuncs.EAI(ag,ai,act)
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
