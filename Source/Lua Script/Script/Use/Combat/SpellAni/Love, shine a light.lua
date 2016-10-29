--[[
  Love, shine a light.lua
  Version: 16.10.29
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
function SpellAni.Light(ActG,ActT,TarG,TarT)
local sx,sy = FighterCoords(TarG,TarT)
local ak,x,y
Image.LoadNew("SA_LIGHT_BASE","GFX/Elements/Light.png") --"GFX/COMBAT/SPELLANI/GLITTER/BASE.PNG")
Image.HotCenter("SA_LIGHT_BASE")
for ak=1,50 do
    DrawScreen()    
    local c = rand(127,255)
    Image.Color(c,c,c) -- rand(0,255),rand(0,255),rand(0,255)
    for al=1,25 do
        x = rand(sx-16,sx+16)
        y = rand(sy-64,sy)
        Image.Rotate(rand(0,360))
        local s = rand(50,100)
        Image.ScalePC(s,s)
        Image.Draw('SA_LIGHT_BASE',x,y)
        Image.ScalePC(100,100)
        Image.Rotate(0)
        end
    Flip()
    end
end

function LichtShow(met)
  local zonder = not met
  -- local sx,sy = FighterCoords(TarG,TarT)
  local ak,x,y
  local duur = { [true] = 100, [false]=50 }
  Image.LoadNew("SA_LIGHT_BASE","GFX/Elements/Light.png") --"GFX/COMBAT/SPELLANI/GLITTER/BASE.PNG")
  Image.HotCenter("SA_LIGHT_BASE") 
  for ak=1,duur[met] do
    DrawScreen()    
    if met then
       Image.SetAlphaPC(ak)
       White()
       Image.Rect(0,0,800,600)
       Image.SetAlphaPC(100)
       ShowParty()
    end    
    local c = rand(127,255)
    Image.Color(c,c,c) -- rand(0,255),rand(0,255),rand(0,255)
    for al=1,150 do
        x = rand(0,800)
        y = rand(0,600)
        Image.Rotate(rand(0,360))
        local s = rand(50,100)
        Image.ScalePC(s,s)
        Image.Draw('SA_LIGHT_BASE',x,y)
        Image.ScalePC(100,100)
        Image.Rotate(0)
        end
    Flip()
    end

end

function SpellAni.Solaria(ActG,ActT,TarG,TarT)
  local met = true
  local zonder = false
  LichtShow(zonder)
end

function SpellAni.WhiteApocalypse(ActG,ActT,TarG,TarT)
  local met = true
  local zonder = false
  LichtShow(met)
end

function SpellAni.RewardLight()
  Award('ALLABL_XENOBI')
end  


-- @IF IGNORE
return SpellAni
-- @FI
