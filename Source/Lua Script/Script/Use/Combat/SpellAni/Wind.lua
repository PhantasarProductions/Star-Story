--[[
  Wind.lua
  Version: 16.08.25
  Copyright (C) 2014, 2016 Jeroen Petrus Broks
  
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
function SpellAni.BlowAway(TG,TT,TA)
local lines = {}
local ak,ln
local modspd = 0
for ak=0,2500 do
    table.insert(lines,{sx=rand(600,1500),ex=rand(1,400),y=rand(0,598),spd=rand(4,10),c=rand(100,255)})
    end
local ok
SFX('Audio/SFX/SpellAni/BlowAway.ogg')
while not ok do
      ok = true
      DrawScreen()
      for ak,ln in ipairs(lines) do
          Image.Color(ln.c,ln.c,ln.c)
          Image.Line(ln.sx,ln.y,ln.sx+ln.ex,ln.y)
          ok = ok and ln.sx+ln.ex<0
          lines[ak].sx = lines[ak].sx-ln.spd
          end
      --[[    
      if TA then    
         if (not FoeData[TA.Target].Boss) and (upper(left(Foe[TA.Target]),5)~="KIDS_") then    
            if modspd<10 then modspd = modspd + .02 end
            enemspotmod[TA.Target].x = enemspotmod[TA.Target].x - modspd
            end
         end
      ]]          
      Flip()   
      end    
end



function SpellAni.Hurricane()
SpellAni.BlowAway(false,false,false)
end



function SpellAni.Breeze(TG,TT,TA)
local lines = {}
local ak,ln
local modspd = 0
SFX('Audio/SFX/SpellAni/Breeze.ogg')
for ak=0,100 do
    table.insert(lines,{sx=rand(600,1500),ex=rand(1,400),y=rand(0,598),spd=rand(4,10),c=rand(100,255)})
    end
local ok
while not ok do
      ok = true
      DrawScreen()
      for ak,ln in ipairs(lines) do
          Image.Color(ln.c,ln.c,ln.c)
          Image.Line(ln.sx,ln.y,ln.sx+ln.ex,ln.y)
          ok = ok and ln.sx+ln.ex<0
          lines[ak].sx = lines[ak].sx-ln.spd
          end
      Flip()   
      end    
end
