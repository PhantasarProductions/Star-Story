--[[
  Resistance names.lua
  
  version: 15.10.04
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
]]
R_FATAL = 0
R_SUPERWEAK = 1
R_WEAK = 2
R_DEFAULT = 3
R_HALVE = 4
R_IMMUNE = 5
R_ABSORB = 6


ResistanceArray = {

  [R_FATAL]      = { Name="Fatal", FR=255, FG=0, FB=0, BR=0, BG=0, BR=0}, -- Now BR should be 255 in stead of FR but for some silly reason, this is ignored.
  [R_SUPERWEAK]  = { Name="Super Weak",FR=255,FG=0, FB=0},
  [R_WEAK]       = { Name="Weak", FR=255, FG=100,FB=0},
  [R_DEFAULT]    = { Name="--",FG=180,FB=255, FR=0},
  [R_HALVE]      = { Name="Halved",FG=100,FR=100,FB=100},
  [R_IMMUNE]     = { Name="Immune",FG=255, FR=255, FB=255},
  [R_ABSORB]     = { Name="Absorb",FG=255, FR=0, FB=0}
  
  }
  
ResistanceUnknown = { "???",BR=255,BG=180}  
  
function ResTxt(Tag,x,y,ah,av)
local tx = ResistanceArray[Tag] or ResistanceUnknown
DarkText(tx.Name,x,y,ah,av,tx.FR,tx.FG,tx.FB,tx.BR or 0,tx.BG or 0,tx.BB or 0)
end  

ElementList = {"Fire","Wind","Water","Earth","Light","Dark","Lightning","Frost"}




StatusTypeList = {"*Buff","*Debuff","Poison","Paralysis","Disease","Will","Block","Death","Damned"}
-- Will = Confusion, Charmed, Fear or Oppression of a certain (bad) move. 
-- Blocked = Silenced, however I used a different name in order to make it more fit in this ScyFy setting
-- Damned = Anything unholy, like "Undead".
-- Any StatusType prefixed with a "*" will be ignored in the status screen. The "*" does not have to be imprinted in moves making use of this. 


function iStatus(stars,indexes)
local r,v
if stars then
   r = StatusTypeList
   else
   r = {}
   for _,v in ipairs(StatusTypeList) do 
       if left(v,1)~="*" then table.insert(r,v) end 
       end
   end 
local i=0
return function()
       i = i + 1
       if r[i] then
          if indexes then return i,Str.Replace(r[i],"*","") else return Str.Replace(r[i],"*","") end
          end
       end
end
