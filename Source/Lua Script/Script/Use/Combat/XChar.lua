--[[
**********************************************
  
  XChar.lua
  (c) Jeroen Broks, 2015, 2016, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 16.09.28
]]

-- Kills for ExHuRU (and his "representatives")  


function XCharAutoAllow(ch)
  local allow = {"Poison","Disease","Damned"}
  local getlist = RPGChar.ListOut(ch,"StatusChanges")
  local list = mysplit(getlist,";")
  local ret = RPGChar.Points(ch,"HP").Have>0  
  for sc in each(list) do
      ret = ret and tablecontains(allow)
  end
  return ret
end
  
  
function XCharKillCount(DoNotCount) -- ExHuRU, Rolf, and Johnson share this one.
if not DoNotCount then inc("%KILLS.DONE") end
local done
local indexes = {3840,1920,960,480,240,120,60,30}
local spells = {
                        [  30] = "YKSI",
                        [  60] = "KAKSI",
                        [ 120] = "BATTLECRY",
                        [ 240] = "KOLME",
                        [ 480] = "STOMP",
                        [ 960] = "NELJA",
                        [1920] = "KUUSI",
                        [3840] = "CONCENTRATE"
                        }
if RPGChar.ListHas("ExHuRU","EXHURU_"..spells[3840])==1 then Award("ALLABL_EXHURU") end
local i,a  
done = CVV("%KILLS.DONE")                      
for i in each(indexes) do
    a = "EXHURU_"..spells[i] -- Due to the linked interfact the others will copy it all the same. 
    if i<=done then
       if RPGChar.ListHas("ExHuRU","ABL",a)==0 and RPGChar.ListHas("ExHuRU","LEARN",a)==0 then RPGChar.AddList("ExHuRU","LEARN",a) return end
       end
    if i>done then Var.D("%KILLS.NEED",i) end   
    end     
end  

XCharKill = {

    ExHuRU  = XCharKillCount,
    Rolf    = XCharKillCount,
    Johnson = XCharKillCount

}


-- Abilities executed for Wendicka

XCharAbility = {

        Wendicka = function()
                   inc("%WENDICKA.DONE")
                   local done = CVV("%WENDICKA.DONE")
                   local need = CVV("%WENDICKA.NEED") 
                   local indexes = {200,90,30,15}
                   local spells = {
                        [15] = "JOLT",
                        [30] = "SHOCKTHERAPY",
                        [90] = "MJOLNIR",
                        [200] = "ELECTRICCHARGE"
                        }
                   local i,a
                   if RPGChar.ListHas("UniWendicka","ABL","WENDICKA_"..spells[200])==1 then Award("ALLABL_WENDICKA") end
                   if done>200 then return end
                   for i in each(indexes) do
                       a = "WENDICKA_"..spells[i] 
                       if i<=done then
                          if RPGChar.ListHas("UniWendicka","ABL",a)==0 and RPGChar.ListHas("UniWendicka","LEARN",a)==0 then RPGChar.AddList("UniWendicka","LEARN",a) return end
                          end
                       if i>done then Var.D("%WENDICKA.NEED",i) end   
                       end     
                   end
                   
                   

    }
    
XCharAbility.UniWendicka = XCharAbility.Wendicka
    
XCharLearnAbility = {

    Wendicka = function() XCharAbility.Wendicka(); RPGChar.Points("UniWendicka","EXP").Inc(2000) end,
    UniWendicka = function() XCharAbility.Wendicka(); RPGChar.Points("UniWendicka","EXP").Inc(2000) end,
    ExHuRU = function() XCharKillCount(false) RPGChar.Points("ExHuRU","EXP").Inc(1250) end,
    Rolf = function() XCharKillCount(false) RPGChar.Points("ExHuRU","EXP").Inc(1250) end,
    Johnson = function() XCharKillCount(false) RPGChar.Points("ExHuRU","EXP").Inc(1250) end,
    Foxy = function() 
       RPGChar.Points("Foxy","EXP").Inc(2000)
       if RPGChar.CountList("Foxy","ABL") == 9 then 
          RPGChar.Points("Foxy","EXP").Inc(9000/3)
          Award('ALLABL_FOXY')
          end 
       end,
    Yirl = function() RPGChar.Points("Yirl","EXP").Inc(3000) end,
  
  }    

XCharAfterAction = {
	
	Foxy = function()
				local lv = RPGChar.Stat("Foxy","Level")
				local foxyused = CVV('%FOXY.USED') * (4-skill)       
				local abilities = { DRAGON_BURN = 200, DRAGON_INFERNO = 8400, STUNSTAB = 6400, BACKSTAB = 1600, CHEER = 25600, SMOKEBOMB = 4600, DRAGON_CHARGE = 65535 }
				local hasall = true
				local hasit,learnit,allowlearn
				local r
				if foxyused<65535 and rand(0,skill)==0 then inc('%FOXY.USED') end
				CSay("Let's see if Foxy learns something new!")
				for abl,rate in pairs(abilities) do
					hasit = RPGChar.ListHas("Foxy","ABL","FOXY_"..abl)==1
					hasall = hasall and hasit
					learnit = RPGChar.ListHas("Foxy","LEARN","FOXY_"..abl)==1
					allowlearn = not(hasit or learnit)
					r = rand(1,rate)
					if CVV("&CHEAT.FOXYALL") then r=1 end -- Cheat to enable me to test out all of Foxy's skills and spells. I mean, depending on the random fact will take forever. ;)
					CSay("Ability: "..abl.."; hasit: "..sval(hasit).."; hasall: "..sval(hasall).."; learnit: "..sval(learnit).."; allowlearn: "..sval(allowlearn).."; rate: "..rate.."; random: "..r)
					if allowlearn and r<lv+foxyused then 
						RPGChar.AddList("Foxy","LEARN","FOXY_"..abl)
						CSay("Learn: "..abl)
					end
				end
				if hasall then Award("ALLABL_FOXY") end				
	        end,
	Yirl = function() 
	       BusinessPoints() -- This should make sure Yirl needs a new move if applicable.
	       end,         
	       
  Wendicka = function()
             if RPGChar.ListHas("UniWendicka","ABL","WENDICKA_ELECTRICCHARGE")==1 then Award("ALLABL_WENDICKA") end
             end	       
	}
XCharAfterAction.UniWendicka = XCharAfterAction.Wendicka	
	
XCharAttacked = {
 
    Foxy = function(attackergroup,attackterindividual)
             if not XCharAutoAllow('Foxy') then return end -- If Foxy is unable to act, she cannot do this either.
             if rand(1,100)>15 then return end -- Only 15% chance Foxy will do this, after this 15% some other factors may play a role.
             local sw = rand(0,5)
             if RPGStat.PartyTag(sw)=="Foxy" or RPGStat.PartyTag(sw)=="" then return end -- Nope, Foxy cannot swap places with herself, neither can she swap with an empty spot.
             local cch = RPGStat.PartyTag(sw)
             if RPGStat.Points(cch,"HP").Have==0 then return end -- Foxy cannot swap with dead party members.	
             local pos
             for i=0,5 do 
             	   if RPGStat.PartyTag(i)=="Foxy" then pos = i end
             	   end
             if Fighters.Hero[pos+1].Gauge>9995 then return end -- Foxy cannot switch when she's about to perform a move             	   
             MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
             MS.Run("BOXTEXT","RemoveData","NEWABILITY")
             MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
             SerialBoxText("NEWABILITY","SPECIAL.FOXY","Combat")
             local cch = RPGStat.PartyTag(sw)	
             RPGChar.SetParty(sw,RPGChar.PartyTag(pos))
						 RPGChar.SetParty(pos,cch)
						 Fighters.Hero[pos+1] = { Tag = cch, Gauge=9995 }
						 if sw<3 then Fighters.Hero[sw+1] = { Tag = 'Foxy', Gauge=-2000 } end
						 return false -- If true was returned the attack would be cancelled, but this is not the case for Foxy.
             end,
             
    Yirl = function(attackergroup,attackerindividual)
             if not XCharAutoAllow('Yirl') then return end -- If Yirl is unable to act, she cannot do this either.
             if attackergroup=='Hero' then return end
    		     if rand(1,100)>25 then return end  
    		     if RPGChar.Points('Yirl',"AMMO").Have==0 then return end -- Yirl needs at least one bullet to do this.
             MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
             MS.Run("BOXTEXT","RemoveData","NEWABILITY")
             MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
             SerialBoxText("NEWABILITY","SPECIAL.YIRL","Combat")
             local pos
             for i=0,5 do 
             	   if RPGStat.PartyTag(i)=="Yirl" then pos = i end
             	   end
             ActionFuncs.SHT('Hero',pos+1,{TargetGroup='Foe',TargetIndividual=attackerindividual, Act='SHT', Action='SHT'})
             return true
             end,

    Wendicka = function(attackergroup,attackterindividual) -- Odd as it may seem, this is not about Wendicka, but about ExHuRU who responds to Wendicka being attacked.
               if not XCharAutoAllow('ExHuRU') then return end -- If ExHuRU is unable to act, she cannot do this either.
               local hp = RPGChar.Points("Wendicka","HP").Have
               local hpm = RPGChar.Points("Wendicka","HP").Maximum
               if hp>(hpm/2) then return end -- Only respond if Wendicka's health is below 50%
               for i=0,5 do 
             	      if RPGStat.PartyTag(i)=="Wendicka" then pos = i end
             	      if RPGStat.PartyTag(i)=="ExHuRU" then exu=i end
             	      end
             	 if not exu then return end -- If ExHuRU is not in the party at all, don't bother. This fixes #379    
             	 if exu<3 then return end -- ExHuRU can only do this from the back row.
             	 if Fighters.Hero[pos+1].Gauge>9995 then return end -- ExHuRU cannot cancel Wendicka's moves.
               MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
               MS.Run("BOXTEXT","RemoveData","NEWABILITY")
               MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
               SerialBoxText("NEWABILITY","SPECIAL.EXHURU","Combat")
               -- And if Wendicka is now in danger and ExHuRU on the back row the two will automatically switch places.
               RPGChar.SetParty(exu,"Wendicka")
						   RPGChar.SetParty(pos,"ExHuRU")
						   Fighters.Hero[pos+1] = { Tag = "ExHuRU", Gauge=9995 }             	      
               end,
    
    Xenobi = function(attackergroup,attackterindividual)
             local HP = RPGStat.Points('Xenobi','HP')
             local AP = RPGStat.Points('Xenobi','AP')
             if HP.Have<(HP.Maximum/2)/skill then AP.Have=AP.Maximum end
             end     ,

    Johnson = function(ai,ti,gh)
                local HP = RPGStat.Points('Johnson','HP')
                local d = math.floor( (HP.Have/HP.Maximum) * 10)
                if d>0 then
                   MINI(Var.S("$JOHNSON became a bit faster"))
                   RPGStat.IncStat("Johnson","BUFF_Agility")
                end   
              end          
                        

}	
	
XCharAlternateAttack = {

    Wendicka = function(ai,ti,tg)    
               CSay("Wendicka attacks, but is it only an attack?")           
               if rand(1,100)>60/skill then CSay("= Percantage roll failed, let's get outta here") return end -- 30% only that Wendicka even qualifies to do this.
               if ti=="Hero" then CSay("= Nope! Not gonna do this on fellow heroes") return end -- This will not happen if Wendicka attacks one of her allies in confused state.
               if Fighters.Foe[ti].Boss then CSay("= Nope! Not gonna do this on bosses") return end -- No go on bosses! 
               local foetag = Fighters.Foe[ti].Tag
               local wentag = Fighters.Hero[ai].Tag -- (Important to know since Wendicka can also do this in her uniform form)
               local wenhp = RPGChar.Points("UniWendicka","HP").Have -- Wendicka and UniWendicka share their HP, so this is easy to do.
               local foehp = RPGChar.Points(foetag,'HP').Have
               CSay(" = Foe: "..foetag.."; Wendicka "..wentag)
               if rand(1,foehp)>rand(0,wenhp) then CSay("= HP check failed") return end -- The better Wendicka's health and the worse the enemy's health the bigger the chance Wendicka will do this.
               -- All stuff out of the way! Let's kill 'em, boys!
               CSay("= Everything ok, let's kill them guys!")
               MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
               MS.Run("BOXTEXT","RemoveData","NEWABILITY")
               MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
               SerialBoxText("NEWABILITY","SPECIAL."..upper(wentag),"Combat")
               AnimateHero(ai,{ Act = "ATK"})
               CharReport(tg,ti,"DEATH!",{255,0,0})
               RPGChar.Points(foetag,'HP').Have = 0
               return true      
               end,
    Rolf = function(ai,ti,gh)
               if rand(1,100)>30/skill then return end
               MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
               MS.Run("BOXTEXT","RemoveData","NEWABILITY")
               MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
               SerialBoxText("NEWABILITY","SPECIAL.ROLF","Combat")
               local act = Fighters.Hero[ai].Act
               act.ItemCode = "ABL_ROLF_AUTO_CRITICAL"
               act.Item = ItemGet('ABL_ROLF_AUTO_CRITICAL')
               ActionFuncs.ABL('Hero',ai,act)
               return true
           end,        
           
   
}	

XCharAlternateAttack.UniWendicka = XCharAlternateAttack.Wendicka
