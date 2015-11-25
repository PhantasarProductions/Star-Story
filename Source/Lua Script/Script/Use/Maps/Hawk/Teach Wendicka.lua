--[[
**********************************************
  
  Teach Wendicka.lua
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
 
version: 15.11.25
]]
TeachWendickaArray = {

             
             
              Yirl = {
                       Requirement = function() 
                                     return CVV('&WENDICKA.LOVES.YIRL') and RPGChar.ListHas("Yirl","ABL","YIRL_FOLLOWME")
                                     end,
                       Teach = 'YIRL_FOLLOWME'              
                     },
              Foxy = {
                       Requirement = function()
                                     return RPGChar.ListHas("Foxy","ABL","FOXY_DRAGON_CHARGE")==1 or RPGChar.ListCount("Foxy","ABL")==6
                                     end,
                       Teach = 'FOXY_PICKPOCKET'              
                     },
              Rolf = {
                       Requirement = function()
                                     return RPGChar.ListHas("Rolf","ABL","EXHURU_KAKSI")==1 and CVV("&NIZOZEMSKASIDEQUEST") and RPGStat.Stat("Wendicka","Level")>=50
                                     end,
                       Teach = "EXHURU_KAKSI"              
                     },
              Xenobi = {
                       Requirement = function()
                                     return RPGStat.Stat("Wendicka","Level")>=50 and RPGChar.ListHas("Xenobi","ABL","XENOBI_VITALIZE") and CVV("&BOSS.DARDBOORTH") and CVV("&GODDESS.RELEASED") 
                                     end,
                       Teach = "XENOBI_VITALIZE"              
                       }       

           }
           
function TeachWendicka(bych)
CSay("Teach Wendicka routine:")
if GetActive()~="Wendicka" then return CSay("= Hey, you are not Wendicka!") end
CSay("= Teacher: "..bych)
local teacher = TeachWendickaArray[bych]
if not teacher then return CSay("= It seems this person has nothing to teach to Wendicka.") end
if not teacher.Requirement() then return CSay("= It appears you did not yet meet this teacher's requirement") end
if RPGChar.ListHas("Wendicka","ABL",teacher.Teach)   then return CSay("= Wendicka already knows what this teacher has got to teach") end
if RPGChar.ListHas("Wendicka","LEARN",teacher.Teach) then return CSay("= Wendicka is already trying to master what this teacher has got to teach") end
CSay("= Remark")
MapText("TEACH."..bych)
CSay("= Teaching: "..teacher.Teach)
RPGChar.AddList("Wendicka","LEARN",teacher.Teach)
CSay("= And that should do it.")
end


           
