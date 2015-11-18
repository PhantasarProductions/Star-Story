--[[
  Schuif.lua
  Version: 15.11.18
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

-- @UNDEF DEBUGSCHUIF

Schuif = Schuif or { Ga={}, Obj={} }
-- In case you were wondering "Schuif" is the tribe of the Dutch verb 'Schuiven'.
-- A word hard to translate to English as there are multiple translations possible, but in this particular case you can translate it as "slide".
-- "Schuifdeur" is the Dutch term for "Sliding door".

function DoSchuif() -- Should be present in all maps MAP_FLOW() function when they use this routine. If no MAP_FLOW() is present this file can do it.
local obj
-- @IF DEBUGSCHUIF
local y = 5
Image.NoFont()
-- @FI
for deur,toestand in pairs(Schuif.Ga) do
    if Maps.Obj.Exists(Schuif.Obj[deur])==1 then
       obj = Maps.Obj.Obj(Schuif.Obj[deur])
       -- CSay("Deur = "..sval(deur).."; Toestand = "..sval(toestand))
       -- CSay("Schuif = "..sval(Schuif))
       if obj.X>Schuif[deur][toestand][1] then obj.X = obj.X - 1 elseif obj.X<Schuif[deur][toestand][1] then obj.X = obj.X + 1 end
       if obj.Y>Schuif[deur][toestand][2] then obj.Y = obj.Y - 1 elseif obj.Y<Schuif[deur][toestand][2] then obj.Y = obj.Y + 1 end
       -- @IF DEBUGSCHUIF
       DarkText('Deur '..deur..' = '..toestand.."; ObjXY("..obj.X..","..obj.Y.."); MoetZijnXY("..Schuif[deur][toestand][1]..","..Schuif[deur][toestand][2]..")",5,y,0,0,255,180,0)
       y = y + 15
       -- @FI
       end
    end
end

MAP_FLOW = MAP_FLOW or DoSchuif


function InitSchuif(obj,modx,mody,mode)
Schuif[obj] = { Dicht = { Maps.Obj.Obj(obj).X ,  Maps.Obj.Obj(obj).Y }}
Schuif[obj].Open = { Schuif[obj].Dicht[1]+modx,Schuif[obj].Dicht[2]+mody }
Schuif.Ga[obj] = mode or 'Dicht' -- 'Dicht' is the Dutch word for 'closed'.
Schuif.Obj[obj] = obj -- Leftover from doing things too fast when scripting the Hawk.
CSay("Schuif object '"..obj.."' set!")
end

function SetSchuif(objlist,mode)
local ol=objlist
if type(ol)=='string' then ol = {objlist} end
for obj in each(ol) do
    if not Schuif[obj] then return CSay("WARNING! I don't have an object "..sval(obj)) end
    Schuif.Ga[obj] = mode
    CSay("Object "..obj.." should now be "..mode.." and is "..sval(Schuif.Ga[obj]))
    end
end

function SetSchuif2(array)
SetSchuif(array[1],array[2])
end

function OpenSchuif(zone,obj)
CSay("OpenSchuif("..zone..",",sval(obj))
ZA_Enter(zone,SetSchuif2,{obj,'Open'})
ZA_Leave(zone,SetSchuif2,{obj,'Dicht'})
end

Console.Write("The 'Schuif' module has been properly imported!")
