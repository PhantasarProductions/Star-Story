--[[
  LearnSpellMessages.lua
  Version: 15.09.15
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
function needkills()
local need = CVV("%KILLS.NEED") - CVV("%KILLS.DONE")
if CVV("%KILLS.NEED")<=0 then return end
if need==0 then return "Attack any enemy" end
return "Perform "..need.." kills"
end


learnspellmessages = {

--    UniWendicka = function() return "Wendicka will be able to learn new abilities after this prologue" end,
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
