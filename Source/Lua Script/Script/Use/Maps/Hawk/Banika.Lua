--[[
**********************************************
  
  Banika.Lua
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
 
version: 16.02.19
]]



-- The correct name is BANIKA and not BAKINA.
-- However a little mistake made me have to stick with BAKINA inside the code.
-- The output to the player should be correct though (sigh).
function NPC_Bakina()
if not Done("&BAKINA.DE_EERSTE_KEER") then MapText("BAKINA.NEW") end
local Keuze = RunQuestion("MAP","BAKINA.MENU")
;( {   

      function() -- Aurina Exchange
      MS.Run("PARTY","RunCashCaps")
      if CVV("%AURINAS")==0 then MapText("BAKINA.GEENAURINA") return end
      Var.D("%AURINARATE",CVVN("%AURINARATE") or (5-skill))
      local aurina = CVV("%AURINAS")
      local rate = CVV("%AURINARATE")
      local total = aurina * rate
      Var.D("%AURINACREDITS",total)
      MapText("BAKINA.AURINA")
      inc("%CASH",total)
      inc('%AURINAEXCHANGED',aurina)
      Var.Clear("%AURINAS")      
      -- MapText("BAKINA.BYE")
      end,
      
      function() -- Offensive items
      GoToStore("HAWK_BANIKA_ATTACK")
      end,
            
      function() -- Healing items
      GoToStore("HAWK_BANIKA_HEAL")
      end      

} )[Keuze]() 
end
