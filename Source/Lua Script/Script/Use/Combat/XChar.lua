--[[
**********************************************
  
  XChar.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 
version: 15.10.20
]]

-- Kills for ExHuRU (and his "representatives")  
  
  
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
                        [3840] = "COCENTRATE"
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
    Johnson = function() XCharKillCount(false) RPGChar.Points("ExHuRU","EXP").Inc(1250) end
  
  }    

XCharAfterAction = {
	
	Foxy = function()
				local lv = RPGChar.Stat("Foxy","Level")
				local abilities = { DRAGON_BURN = 200, DRAGON_INFERNO = 400, BACKSTAB = 1600, CHEER = 25600, SMOKEBOMB = 4600, DRAGON_CHARGE = 6553600 }
				local hasall = true
				local hasit,learnit,allowlearn
				local r
				CSay("Let's see if Foxy learns something new!")
				for abl,rate in pairs(abilities) do
					hasit = RPGChar.ListHas("Foxy","ABL","FOXY_"..abl)==1
					hasall = hasall and hasit
					learnit = RPGChar.ListHas("Foxy","LEARN","FOXY_"..abl)==1
					allowlearn = not(hasit or learnit)
					r = rand(1,rate)
					CSay("Ability: "..abl.."; hasit: "..sval(hasit).."; hasall: "..sval(hasall).."; learnit: "..sval(learnit).."; allowlearn: "..sval(allowlearn).."; rate: "..rate.."; random: "..r)
					if allowlearn and r<lv then 
						RPGChar.AddList("Foxy","LEARN","FOXY_"..abl)
						CSay("Learn: "..abl)
					end
				end
				if hasall then Award("ALLABL_FOXY") end				
	        end
	}
	
	
XCharAttacked = {
 
    Foxy = function(attackergroup,attackterindividual)
             MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
             MS.Run("BOXTEXT","RemoveData","NEWABILITY")
             MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
             SerialBoxText("NEWABILITY","SPECIAL.FOXY","Combat")
             if rand(1,100)>15 then return end -- Only 15% chance Foxy will do this, after this 15% some other factors may play a role.
             local sw = rand(0,5)
             if RPGStat.PartyTag(sw)=="Foxy" or RPGStat.PartyTag(sw)=="" then return end -- Nope, Foxy cannot swap places with herself, neither can she swap with an empty spot.
             local cch = RPGStat.PartyTag(sw)
             if RPGStat.Points(cch,"HP").Have==0 then return end -- Foxy cannot swap with dead party members.	
             local pos
             for i=0,5 do 
             	   if RPGStat.PartyTag(sw)=="Foxy" then pos = i end
             	   end
             local cch = RPGStat.PartyTag(sw)	
             RPGChar.SetParty(sw,RPGChar.PartyTag(pos))
						 RPGChar.SetParty(pos,cch)
						 Fighters.Hero[pos+1] = { Tag = cch, Gauge=9995 }
						 return false -- If true was returned the attack would be cancelled, but this is not the case for Foxy.
             end

}	
	
	
