--[[
/* 
  

  Copyright (C) 2015 Jeroen P. Broks

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

*/



Version: 15.05.22

]]
function needkills()
local need = CVV("%KILLS.NEED") - CVV("%KILLS.DONE")
if CVV("%KILLS.NEED")<=0 then return end
if need==0 then return "Attack any enemy" end
return "Perform "..need.." kills"
end


learnspellmessages = {

      UniWendicka = function() return "Wendicka will be able to learn new abilities after this prologue" end,
      UniCrystal  = function() return "Crystal will be able to learn new abilities after this prologue" end,
      Briggs      = function() return "Briggs is not able to learn new abilities" end,
      Wendicka    = function()
                    local need = CVV("%WENDICKA.NEED") - CVV("%WENDICKA.DONE")
                    if CVV("%WENDICKA.NEED")==0 then return end
                    if need<=0 then return "Attack any enemy to learn a new spell" end
                    return "Perform "..need.." spells to unlock a new one"
                    end,
      Crystal     = function() return "" end,              
      Yirl        = function()
                    local need = CVV("%MONEY.NEED") - CVV("%MONEY.DONE")
                    if CVV("%MONEY.NEED")==0 then return end
                    if need<=0 then return "Attack any enemy" end
                    return "Earn "..need.." credits to unlock a new skill"
                    end,
      Foxy        = function() return "???" end,
      Xenobi      = function()              
                    local need = CVV("%MONEY.NEED") - CVV("%MONEY.DONE")
                    if CVV("%XENOBI.NEED")==0 then return end
                    if need<=0 then return "Attack any enemy" end
                    return "Gain "..need.." levels to learn a new spell"
                    end,
      ExHuRU      = needkills,
      Rolf        = needkills,
      Johnson     = needkills              

}


learnspellmessages.UniWendicka = learnspellmessages.Wendicka