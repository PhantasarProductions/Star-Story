--[[
**********************************************
  
  Sisters in all but blood.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
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
 
version: 16.08.20
]]
-- @IF IGNOREME
AblSpecialEffect = {}
-- @FI


function AblSpecialEffect.Sisters(ag,ai,tg,ti,act,foefile)
   local wendicka,crystal
   for i=1,3 do
       if Fighters.Hero[i].Tag=="Wendicka" then wendicka=i end
       if Fighters.Hero[i].Tag=="Crystal"  then crystal=i  end
   end
   if not wendicka then Sys.Error("No Wendicka?") end
   if not crystal then MINI("Wendicka cannot perform this move without Crystal",255,0,0) return end
   MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
   MS.Run("BOXTEXT","RemoveData","NEWABILITY")
   MS.Run("BOXTEXT","LoadData","GENERAL/COMBAT;NEWABILITY")
   SerialBoxText("NEWABILITY","SISTERS","Combat")
   for chi in each({wendicka,crystal}) do
       AblEffect("Hero",wendicka,{
               ItemCsode = "ABL_WENDICKA_SISTERS_ACT",
               Item = ItemGet("ABL_WENDICKA_SISTERS_ACT"),               
       },"Hero",chi)
   end     
end


-- @IF IGNOREME
return AblSpecialEffect
-- @FI

