--[[
  Transporter.lua
  Version: 15.10.27
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
Transporters = Transporters or { Nodes = {}, Worlds={} }

DemoMapsFunction = loadstring(JCR6.LoadString("Script/JINC/Demo/Maps.lua"))
DemoMaps = DemoMapsFunction()

back = "MenuBack"

function ActivatePad(tag)
local obj = Maps.Obj.Obj("Trans.Spot."..tag)
local pad = Maps.Obj.Obj("Trans.Pad." ..tag)
local node = upper(Maps.CodeName.."."..tag)
local demo = false
local layer = nil
if Maps.Multi() then layer=Maps.LayerCodeName end
if Transporters.Nodes[node] then return end
for m in each(DemoMaps) do demo = demo or upper(Maps.CodeName)==m end
CSay("Activating transporter: "..tag)
Transporters.Nodes[node] = { Map = Maps.CodeName, Transporter = "Trans.Spot."..tag, Demo=demo, Layer=layer }
Transporters.Worlds[obj.DataGet("WORLD")] = Transporters.Worlds[obj.DataGet("WORLD")] or {}
table.insert(Transporters.Worlds[obj.DataGet("WORLD")],{Location = obj.DataGet("LOCATION"), Node=node}) 
end

function TransferActivatedPads()
local ret = "{ "
for k,v in pairs(Transporters.Nodes) do 
	if ret~="{ " then ret = ret .." , " end
	ret = ret .. '"'..k..'"'
    end
Var.D("$RET",ret.." }")
end

function ActivateRemotePad(tag,mapcode,world,location)
local node = upper(mapcode.."."..tag)
CSay("Activating transporter: "..tag)
Transporters.Nodes[node] = { Map = mapcode, Transporter = "Trans.Spot."..tag }
Transporters.Worlds[world] = Transporters.Worlds[world] or {}
table.insert(Transporters.Worlds[world],{Location = location, Node=node}) 
CSay('We now have '..#Transporters.Worlds[world].." transporters activated in world "..world)
end

function FirstWorld(world,mapfunction) -- Perfrom this function on the Hawk if this function is there. (this function will be removed from this record after it's performed)
Transporters.Worlds[world].mapfunction = mapfunction
end

function FirstNode(node,mapfunction)
Transporters.Nodes[node].mapfunction = mapfunction
end

function DrawScreen()
-- Background first
Image.Show(back)
-- Now the content
-- Now the party
-- And the mousepointer
ShowMouse()
end

function CancelCheck()
if mousehit(2) then LAURA.Flow("FIELD") end
end

function MAIN_FLOW()
DrawScreen()
CancelCheck()
end
