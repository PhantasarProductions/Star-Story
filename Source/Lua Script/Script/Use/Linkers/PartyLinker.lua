--[[
  PartyLinker.lua
  Version: 15.10.13
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
Party = Party or function(...)
local p = ""
local i,v
Console.Write("Preparing call to the party API",255,180,0)
for i,v in ipairs(arg) do 
    if i>1 then p=p..";" end
    p = p .. v
    end
MS.Run("PARTY","Party",p)
end

    
    
ShowParty = ShowParty or function()
MS.Run("PARTY","ShowParty")
if XShowParty then XShowParty() end
end


function ClickedChar(chn)
if chn<3 then return RPGChar.PartyTag(chn)~="" and mousehit(1) and INP.MouseY()>500 and INP.MouseX()>=chn*200 and INP.MouseX()<(chn+1)*200 end
return RPGChar.PartyTag(chn)~="" and mousehit(1) and INP.MouseY()>550 and INP.MouseY()<580 and INP.MouseX()>=650+((chn-3)*30) and INP.MouseX()<=680+((chn-3)*30)
end    

function RightClickedChar(chn)
if chn<3 then return RPGChar.PartyTag(chn)~="" and mousehit(2) and INP.MouseY()>500 and INP.MouseX()>=chn*200 and INP.MouseX()<(chn+1)*200 end
end    

function MINI(...)
MS.Run("PARTY","Mini",join(arg,";"))
end
Mini = Mini or MINI -- Now we got it covered in the console, and no conflicts with the "real" routine either.
