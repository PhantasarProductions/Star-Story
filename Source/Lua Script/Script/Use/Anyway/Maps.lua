--[[
  Maps.lua
  Version: 16.05.13
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
function MapLevel()
-- local ret = 1
local ptv = ngpcount + 1
local ptg
repeat
ptv = ptv - 1
ptg = "PT"..right("   "..ptv,3).." Level"
if ptv<=0 then return 1 end
CSay("Checking "..ptv.." >> '"..ptg.."' >>> "..Maps.GetData(ptg))
until Maps.GetData(ptg)~=""
return Sys.Val(Maps.GetData(ptg))
end

function MapEXP(modifier,typemodifier)
local m = modifier or 1
local t = typemodifier or "*"
local l = MapLevel();
({
    ["*"] = function() l=l*m end,
    ["+"] = function() l=l+m end,
    ["-"] = function() l=l-m end,
    ["/"] = function() l=l/m end})[t]()
local ch
local chi
for chi=0,5 do
    ch = RPGChar.PartyTag(chi)
    if ch~="" then
       CSay(ch.." gains expierence based on level "..l) 
       GrantExperienceOnLevel(ch,l)
       end
    end    
end

function SpawnPlayer(spot,Wind,teleporteffect,Labels,Bundle)
Actors.Spawn(spot,Bundle or "GFX/Actors/Player","PLAYER")
Maps.CamX = Actors.PX("PLAYER")-400
Maps.CamY = Actors.PY("PLAYER")-300
if teleporteffect==true then
   Actors.ChoosePic("PLAYER","TELEPORT")
   Actors.Actor("PLAYER").NotInMotionThen0 = 0
   MapShow(Labels)
   for f=99,0,-1 do
       Image.Cls()
       Actors.Actor("PLAYER").Frame = f 
       Maps.Draw()
       Flip()    
       end
   end   
local cp = GetActive()    
Actors.ChoosePic("PLAYER",upper(cp).."."..upper(Wind or "SOUTH"))     
TurnPlayer(Wind or "South")  
-- Var.D("%LASTSPAWN.X",Actors.PX("PLAYER"))
-- Var.D("%LASTSPAWN.Y",Actors.PY("PLAYER"))
Var.D("$LASTSPAWN",spot)
end

MapText = MapText or function(tag,back)
local send = tag .. ";" .. (back or "BOXTEXT.KTHURA")
MS.Run("MAP","MapText",send)
end
