--[[
  Transporter.lua
  Version: 16.08.03
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
Transporters = Transporters or { Nodes = {}, Worlds={} }

DemoMapsFunction = loadstring(JCR6.LoadString("Script/JINC/Demo/Maps.lua"))
DemoMaps = DemoMapsFunction()

back = "MenuBack"

function TransporterClearAll()
   Transporters = { Nodes = {}, Worlds={} }
   CurrentWorld = nil
end   

function ActivatePad(tag)
local obj = Maps.Obj.Obj("Trans.Spot."..tag)
local pad = Maps.Obj.Obj("Trans.Pad." ..tag)
local node = upper(Maps.CodeName.."."..tag)
local demo = false
local layer = nil
if Maps.Multi()==1 then layer=Maps.LayerCodeName end
if Transporters.Nodes[node] then return end
for m in each(DemoMaps) do demo = demo or upper(Maps.CodeName)==m end
CSay("Activating transporter: "..tag)
Transporters.Nodes[node] = { Map = Maps.CodeName, Transporter = "Trans.Spot."..tag, Demo=demo, Layer=layer }
Transporters.Worlds[obj.DataGet("WORLD")] = Transporters.Worlds[obj.DataGet("WORLD")] or {}
table.insert(Transporters.Worlds[obj.DataGet("WORLD")],{Location = obj.DataGet("LOCATION"), Node=node}) 
end

function FixPadLayer(tag,layer) -- to fix a bug that came up with the pad in Y Anhysbys.
local obj = Maps.Obj.Obj("Trans.Spot."..tag)
local pad = Maps.Obj.Obj("Trans.Pad." ..tag)
local node = upper(Maps.CodeName.."."..tag)
-- ActivatePad(tag)
Transporters.Nodes[node].Layer = layer or Maps.LayerCodeName
end

function TransferActivatedPads()
local ret = "{ "
for k,v in pairs(Transporters.Nodes) do 
	if ret~="{ " then ret = ret .." , " end
	ret = ret .. '"'..k..'"'
    end
Var.D("$RET",ret.." }")
end

function ActivateRemotePad(tag,mapcode,world,location,layer,mynode)
local node = mynode or upper(mapcode.."."..tag)
CSay("Activating transporter: "..tag)
Transporters.Nodes[node] = { Map = mapcode, Transporter = "Trans.Spot."..tag, Layer=layer }
Transporters.Worlds[world] = Transporters.Worlds[world] or {}
table.insert(Transporters.Worlds[world],{Location = location, Node=node}) 
CSay('We now have '..#Transporters.Worlds[world].." transporters activated in world "..world)
end

function ReDefNode(tag,mapcode,world,location,layer,node)
if not Transporters.Nodes[node] then ActivateRemotePad(tag,mapcode,world,location,layer,node); return end
Transporters.Nodes[node] = { Map = mapcode, Transporter = "Trans.Spot."..tag, Layer=layer }
for d in each ( Transporters.Worlds[world] ) do
    if d.Node==node then d.Location = location end
    end
end

function FirstWorld(world,mapfunction) -- Perfrom this function on the Hawk if this function is there. (this function will be removed from this record after it's performed)
Transporters.Worlds[world].mapfunction = mapfunction
end

function FirstNode(node,mapfunction)
Transporters.Nodes[node].mapfunction = mapfunction
end

function BlockWorld(world)
Transporters.Worlds[world].Blocked = true
end 

function UnBlockWorld(world)
Transporters.Worlds[world].Blocked = nil
CSay('Unblocked: '..world)
end 

function DrawScreen()
local y = 0
local mx,my = MouseCoords()
local nodedata
-- Background first
Image.Show(back)
-- Now the content
if CurrentWorld then
   if Transporters.Worlds[CurrentWorld].Blocked then CurrentWorld=nil return end -- No access to blocked worlds
   Image.Color(255,0,0)
   SetFont('TerminalHeader')
   Image.DText(CurrentWorld,300,15)
   y = 30
   SetFont('Terminal')
   if my>30 and my<45 then 
   	  Image.Color(180,255,0)
   	  if mousehit(1) then CurrentWorld=nil; return end
   else
      Image.Color(0,180,0)
      end
   Image.DText("../",80,y) y = 60
   for data in each(Transporters.Worlds[CurrentWorld]) do   
       nodedata = Transporters.Nodes[data.Node]
       if my>y and my<y+15 then 
          Image.Color(0,180,255)
          if mousehit(1) then
             if nodedata.mapfunction then
                LAURA.Flow("FIELD")
                MS.Run("MAP",nodedata.mapfunction)
                nodedata.mapfunction = nil
             else
                Image.Cls()
                LoadMap(nodedata.Map,nodedata.Layer or nodedata.layer or "#001")
                SpawnPlayer(nodedata.Transporter,"South") --,true)
                LAURA.Flow("FIELD")
                end 
             end
       else   
          Image.Color(0,100,180)
          end 
       Image.DText(data.Location,80,y)
       y = y + 20
       end
else
   y = 15
   SetFont('Terminal')
   for w,data in spairs(Transporters.Worlds) do
       if Transporters.Worlds[w].Blocked then
          Image.Color(80,80,80)
       elseif my>y and my<y+15 then 
          Image.Color(0,180,255)
          if mousehit(1) then 
             CurrentWorld = w
             if Transporters.Worlds[w].mapfunction then
                LAURA.Flow("FIELD")
                MS.Run("FIELD","Schedule","MAP;"..Transporters.Worlds[w].mapfunction)
                if not Transporters.Worlds[w].mapfunctionpermanent then Transporters.Worlds[w].mapfunction = nil end
                end 
             end
       else   
          Image.Color(0,100,180)
          end 
       Image.DText(w,80,y)
       y = y + 20
       end
   end
-- Now the party
ShowParty()
-- And the mousepointer
ShowMouse()
end

function CancelCheck()
if mousehit(2) then LAURA.Flow("FIELD") end
end

function MAIN_FLOW()
DrawScreen()
CancelCheck()
Flip()
end
