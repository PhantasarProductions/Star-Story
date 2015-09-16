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
 
version: 15.09.16
]]

-- Kills for ExHuRU (and his "representatives")  
  
  
function XCharKillCount(DoNotCount) -- ExHuRU, Rolf, and Johnson share this one.
if not DoNotCount then inc("%KILLS.DONE") end
local done
local indexes = {3840,1920,960,480,240,120,60,30}
local spells = {
                        [  30] = "YSKI",
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
                   if RPGChar.ListHas("UniWendicka","WENDICKA_"..spells[200])==1 then Award("ALLABL_WENDICKA") end
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

    Wendicka = XCharAbility.Wendicka,
    UniWendicka = XCharAbility.Wendicka,
    ExHuRU = function() XCharKillCount(false) end,
    Rolf = function() XCharKillCount(false) end,
    Johnson = function() XCharKillCount(false) end
  
  }    
