--[[
/* 
  Mouse

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

*/



Version: 15.06.27

]]


function MouseCoords()
return INP.MouseX(),INP.MouseY()
end
mousecoords = MouseCoords

function TrueMouseCoords()
local x,y = MouseCoords()
return x+Maps.CamX,y+Maps.CamY
end 

function ShowMouse(Img)
White()
if INP.KeyD(KEY_DOWN )==1 then INP.IncMouse( 0, 2) end
if INP.KeyD(KEY_UP   )==1 then INP.IncMouse( 0,-2) end
if INP.KeyD(KEY_RIGHT)==1 then INP.IncMouse( 2, 0) end
if INP.KeyD(KEY_LEFT )==1 then INP.IncMouse(-2, 0) end
local x,y = MouseCoords()
Image.Draw(Img or "MOUSE",x,y)
end

function mousehit(k)
local ret
local hits = 
   {
     [1] = { INP.MouseH(1)==1, INP.KeyH(KEY_SPACE)==1, INP.KeyH(KEY_ENTER)==1},
     [2] = { INP.MouseH(2)==1, INP.KeyH(KEY_ESCAPE)==1}
   }
local i,b
for i,b in ipairs(hits[k]) do 
    ret=ret or b 
    -- Image.DText("MouseHit["..k.."]  "..i..".."..sval(b).." >> "..sval(ret),700,(i*100)+k*20,1) -- debug line
    end
return ret 
end 

function keyhit(k)
return INP.KeyH(k)~=0 
end 
