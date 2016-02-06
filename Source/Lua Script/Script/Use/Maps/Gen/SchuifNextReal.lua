--[[
  SchuifNextReal.lua
  Version: 16.01.26
  Copyright (C) 2016 Jeroen Petrus Broks
  
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
if not(Next and Prev) then Sys.Error("No next?") end


SchuifNextExtraInit = SchuifNextExtraInit or {}



function OpenPrev()
SetSchuif({"PrevLinks","PrevRechts"},"Open")
end

function OpenNext()
SetSchuif({"NextLinks","NextRechts"},"Open")
end

function SluitPrev()
SetSchuif({"PrevLinks","PrevRechts"},"Dicht")
end

function SluitNext()
SetSchuif({"NextLinks","NextRechts"},"Dicht")
end


function SchuifNextLayerCheck()
local lay = Maps.LayerCodeName
if oldschuiflay~=lay then
   Schuif = SchuifNextArray[lay]
   oldschuiflay = lay
   end
end
   
function SchuifNextDo()
SchuifNextLayerCheck()
OriginalDoSchuif()
end

OriginalDoSchuif = DoSchuif
DoSchuif = SchuifNextDo
if MAP_FLOW==OriginalDoSchuif then MAP_FLOW = SchuifNextDo end

SchuifNextArray = {}

function SchuifNextSetup()
local function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
      end -- Needed as @USE is not yet fully completed here.
local layers = {"*"} -- In non multi-map we need at least one "layer"
local orilayer
if Maps.Multi()==1 then layers = mysplit(Maps.Layers(),";") orilayer=Maps.LayerCodeName else Sys.Error("Using SchuifNext.lua require Multi-Map") end
for lay in each(layers) do
    Maps.GotoLayer(lay)
    Console.Write("= Setting up SchuifNext layer: "..lay,180,255,0)
    SchuifNextArray[lay] = { Ga={}, Obj={} }
    Schuif = SchuifNextArray[lay] -- Needed for the original schuif.lua routines
    if Maps.Obj.Exists("SchuifNext")==1 then
       InitSchuif("NextLinks",-30,0,"Dicht")
       InitSchuif("NextRechts",30,0,"Dicht")
       ZA_Enter("SchuifNext",OpenNext); ZA_Leave("SchuifNext",SluitNext)
       else
       Console.Write("No 'Next' on this floor: "..lay,255,0,0)
       end
    if Maps.Obj.Exists("SchuifPrev")==1 then
       InitSchuif("PrevLinks",-30,0,"Dicht")
       InitSchuif("PrevRechts",30,0,"Dicht")
       ZA_Enter("SchuifPrev",OpenPrev); ZA_Leave("SchuifPrev",SluitPrev)
       else
       Console.Write("No 'Prev' on this floor: "..lay,255,0,0)
       end
    (SchuifNextExtraInit[lay] or function() Console.Write("No extra init for floor "..lay,255,180,0) end)()   
    end
Maps.GotoLayer(orilayer)    
N_PrevList = { function() SchuifNextLayerCheck() OpenNext() DoInstantSchuif() end }
N_NextList = { function() SchuifNextLayerCheck() OpenPrev() DoInstantSchuif() end }
end 

SchuifNextSetup()
