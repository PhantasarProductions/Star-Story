--[[
  Business Points.lua
  Version: 16.07.12
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




--[[

      Business points.
      
      This script was specifically set up for Star Story.
      The character Yirl learns new moves based on how many points you have here in total.
      
      After every move Yirl does in battle, this score will be checked and its value determines if Yirl will learn a new move or not.
      
      Current scoring table.
      - 10 points for every aurina you pocess
      - 5 points for every aurina you've exchanged for money
      - 1 point per 200 credits
      - 1 point per 300 credits spent 
      - 5 points per item you pocess on any character (he or she MUST be in the active party on the moment of checking).
      - 2.5 points per item stored in the vault
      = 1 point per 10 shilders in the easy mode, 25 shilders in the normal mode and 50 shilders in the hard mode
      
      - I do set %BUSINESSBONUS value, which might have extra points after completing some bonus missions (I just want to keep an option open to myself as nothing has been decided on this one).
      
      All ending values will be rounded with the round() routine.      


]]




function BusinessPoints()
local totalscore = 0
local need = 0
-- general scores
local calcscore = {                     
                      bonus = CVV('%BUSINESSBONUS'),
                      aurinahave = CVV("%AURINAS")*10,
                      aurinaexchanged = CVV('%AURINAEXCHANGED')*5,
                      cash = CVV("%CASH")/200,
                      cashspent = CVV("%CASHTOTALSPENT")/300,
                      shilderhave = CVV("%SHILDERS")/({10,25,50})[skill]
                  }

local ch
-- inventory calculation
for i=0,5 do
   ch = RPGChar.PartyTag(i)
   if ch~="" then
      for socket=1,InventorySockets do
          calcscore.inventory = (calcscore.inventory or 0) + (RPGChar.Stat(ch,'INVAMNT'..socket)*5)
          end
      end
   end
-- vault calculation
for itcode in IVARS() do
    if prefixed(itcode,"%VAULT.") then calcscore.vault = (calcscore.valut or 0)+(CVV(itcode)*2.5) end
    end
-- calculate
for f,v in spairs(calcscore) do
    totalscore = totalscore + v
    end
-- Teach Yirl a new move
local YirlMoves = { TRIGGERHAPPY = 1400, 
                    TAUNT = 1800,
                    FOLLOWME = 2500,
                    CONFUSION = 3000,
                    DEATHSHOT = 6000
                  }
local abl                  
for ab,abneed in pairs(YirlMoves) do
    abl = "YIRL_"..ab
    if RPGChar.ListHas('Yirl',"ABL",abl)==0 and RPGChar.ListHas('Yirl',"LEARN",abl)==0 then
       if need==0 then need=abneed end
       if totalscore>=abneed then RPGChar.AddList('Yirl','LEARN',abl) end
       end
    end
if need==0 and RPGChar.CountList('Yirl',"LEARN")==0 and (not YirlAchievement) then Award('ALLABL_YIRL') end
-- return
return round(totalscore),need,calcscore    
end

function BUSINESSPOINTS() -- This function is only inteded for the debug console.
local score,need,table = BusinessPoints()
for f,v in spairs(table) do
    CSay(f.." = "..v)
    end
CSay()
CSay("Total: "..score)
CSay("Need: "..need)
end    
