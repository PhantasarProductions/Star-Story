--[[
 **********************************************
  
  This file is part of a closed-source 
  project by Jeroen Petrus Broks and should
  therefore not be in your pocession without
  his permission which should be obtained 
  PRIOR to obtaining this file.
  
  You may not distribute this file under 
  any circumstances or distribute the 
  binary file it procudes by the use of 
  compiler software without PRIOR written
  permission from Jeroen P. Broks.
  
  If you did obtain this file in any way
  please remove it from your system and 
  notify Jeroen Broks you got it somehow. If
  you have downloaded it from a website 
  please notify the webmaster to remove it
  IMMEDIATELY!
  
  Thank you for your cooperation!
  
  
 **********************************************
Wendicka.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.10.13
]]
function GALE_OnLoad()

    function ER_Water(ch)
    if CVV("&GODDESS.RELEASED") then 
       ELEMRESIST(ch,"Water")
       else
       RPGChar.DefStat(ch,"ER_Water",0)
       end
    end
    
    function ER_Lightning(ch)
    if CVV("&GODDESS.RELEASED") then 
       ELEMRESIST(ch,"Lightning")
       else
       RPGChar.DefStat(ch,"ER_Lightning",6)
       end
    end
    
end
