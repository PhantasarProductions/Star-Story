--[[
  SmokeBomb.lua
  Version: 15.11.04
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

--[[
    
    I basically recycled this code from "The Secret Of Dyrt" where Merya had the same move.
    I did need to make a few adeptions to it in order to make it work fully here in LAURA II.
    
]]
    
function SpellAni.SmokeBomb()
local smoke = {} 
local d = { { X=-1, Y=0 }, {X=1,Y=0}, {X=0,Y=-1}, {X=0,Y=1} }
local ak,al,ad,tx,ty,s
local imgsmoke = Image.Load("GFX/Combat/SpellAni/SmokeBomb/Smoke Bomb.png")
Image.HotCenter(imgsmoke)
-- Let's first see which enemies we all got and tie all the smoke sprites to that
for ak,fdata in pairs(Fighters.Foe) do
    if fdata and RPGChar.Points(fdata.Tag,'HP').Have>0 then
       tx,ty = CoordsFighter.Foe(ak)
       for al,ad in ipairs(d) do table.insert(smoke,{gx=ad.X,gy=ad.Y,x=tx,y=ty,alpha=1}) end 
       end
    end
-- Place the enemies out of the screen
for ak,fdata in pairs(Fighters.Foe) do
    if (not fdata.Boss)  then fdata.x = -1000 end
    end     
-- And now, let's roll it, boys
for ak=1,100 do
    DrawScreen()
    for al,s in ipairs(smoke) do
        s.alpha = s.alpha - 0.01
        s.x = s.x + s.gx
        s.y = s.y + s.gy
        Image.SetAlpha(s.alpha)
        Image.Draw(imgsmoke,s.x,s.y)
        end  
    Image.SetAlpha(1)    
    Flip()
    end
-- Remove the smoke image from the memory
Image.Free(imgsmoke)    
end    
