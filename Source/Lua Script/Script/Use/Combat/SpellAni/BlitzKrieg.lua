--[[
  BlitzKrieg.lua
  Version: 16.08.28
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

-- @IF IGNORE
SpellAni = {}
-- @FI

function SpellAni.BlitzKriegDrawClouds(img)
   local sp
   Image.ScalePC(100,100)
   Image.ViewPort(0,300,800,300)
   Image.Origin(0,300,800,300)
   for s,i in pairs(img) do
       sp = (sp or 0) + 2
       if prefixed(s,"Cloud") then Image.Tile(i,Time.MSecs()/sp,00) end
   end
   Image.ViewPort(0,0,800,600)
   Image.Origin(0,0)
   ShowParty()    
end

function SpellAni.BlitzKrieg()
    -- Init
    local seq = {"CaveMan","Cavalry","Tank"}
    local img = {}
    local extra = {"SpaceShip","Cloud1","Cloud2","Cloud3"}
    local dat = {}
    -- Load
    for s   in each(seq)     do img[s]=Image.Load("GFX/Combat/SpellAni/SuperMoves/BlitzKrieg/"..s..".png") end 
    for s   in each(extra)   do img[s]=Image.Load("GFX/Combat/SpellAni/SuperMoves/BlitzKrieg/"..s..".png") end
    for k,v in spairs(img)   do CSay(k .. " has image "..sval(v) ) Image.Hot(v,Image.Width(v)/2,Image.Height(v)) end
    -- Execute ground troups
    repeat
      DrawScreen()
      Image.ScalePC(25,25)
      for i=1,#seq do
         dat[i] = dat[i] or { x = 250 + (i*1200) , y = 500, s = (i/2)+1 }
         Image.Show(img[seq[i]],dat[i].x,dat[i].y)
         dat[i].x = dat[i].x - dat[i].s 
      end
      SpellAni.BlitzKriegDrawClouds(img)
      Flip()      
    until dat[#seq].x<0  
    -- Execute SpaceShit
    local x = 400
    for y = 600,-20,-4 do
        DrawScreen()
        Image.ScalePC(25,25)
        Image.Show(img.SpaceShip,x,y)
        Image.ScalePC(100,100)
        SpellAni.BlitzKriegDrawClouds(img)
        Flip()
    end    
    -- Unload
    for s in each(img) do Image.Free(s) end
end


-- @IF IGNORE
return SpellAni -- Fooling the Eclipse outline routine is fun, isn't it?
-- @FI
