--[[
  World.lua
  Version: 16.05.22
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
local world

local function nothing() end

function LoadWorld(worldfile)
  Music("World/"..worldfile..".ogg")
  world = jinc("Script/JINC/World/"..worldfile..".lua")
  world.font = world.font or "BoxText"
  world.fdata = fonts[world.font]
  ;(world.init or nothing)()
end  
  
function MAIN_FLOW()
   local y,r,g,b
   local mx,my = MouseCoords()
   Cls()
   ;(world.preflow or nothing)()
   SetFont(world.font)
   DarkText(world.name,400,50,2,2,255,0,0)
   for i,loc in ipairs(world.locations) do
       if (not loc.Wanted) or CVV(loc.Wanted) then
          y = (i*world.fdata[2])+100
          r,g,b = 180,180,0
          if my>y and my<y+world.fdata[2] then
             r,g,b = 255,180,0
             if INP.MouseH(1)==1 then
             	  Cls()
             	  Flip()
             	  Cls()
             	  Flip()
                LoadMap(loc.Map,loc.Layer)
                if loc.Layer then Maps.GotoLayer(loc.Layer) end
                SpawnPlayer(loc.Spawn or "Start")
                LAURA.Flow("FIELD")
                MS.Destroy("WORLD")
                ;(loc.OpenEvent or nothing)()
             end
          end   
       DarkText(loc.Name,400,y,2,0,r,g,b)                   
       end
   end
   ;(world.postflow or nothing)()
   ShowParty()
   ShowMouse()
   Flip()
end
