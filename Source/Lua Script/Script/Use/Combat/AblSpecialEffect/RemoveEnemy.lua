--[[
  RemoveEnemy.lua
  Version: 15.10.31
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

-- @IF IGNORE
AblSpecialEffect = {}
-- @FI

function AblSpecialEffect.RemoveEnemy(ag,ai,tg,ti,act)
if myfoe.Boss then return end -- does not work on bosses, ha! ha!
-- Remove the enemy from memory
local myfoe = Fighters.Foe[ti]           
Fighters.Foe[ti] = nil
if RPGChar.CharExists(myfoe.Tag)==1 then RPGStat.DelChar(myfoe.Tag) else CSay("!! WARNING !! Tried to destroy non-existent foe: "..myfoe.Tag) end
-- Optimize time gauge
InitGaugeSpeed()
return true
end

function AblSpecialEffect.Muenchausen(ag,ai,tg,ti,act)
local myfoe = Fighters.Foe[ti]
local cannonball = Image.Load("GFX/Combat/SpellAni/Muenchhaussen/CANNONBALL.PNG")
local starfield = Image.Load('GFX/Intro/Starfield.png')
if myfoe.Boss then
   CSay("Removal rejected. Target is marked as boss enemy!") 
   return 
   end -- does not work on bosses, ha! ha!
-- Fade to the sky
for alpha=0,100 do
    DrawScreen()
    Image.SetAlphaPC(alpha)
    Image.Color(0,200,255)
    Image.Rect(0,0,800,600)
    Image.SetAlphaPC()
    DrawParty()
    ShowMessages()
    end
local cx,cy=700,800
local skyalpha=100
local foeimg = "O"..myfoe.Tag
local sx,sy=0,0
local alpha
repeat
    Image.Tile(starfield,sx,sy)
    Image.SetAlphaPC(alpha)
    Image.Color(0,200,255)
    Image.Rect(0,0,800,600)
    Image.SetAlphaPC()
    Image.Show(cannonball,cx,cy)
    Image.Show(foeimg,cx+(Image.Width(cannonball)/2),cy+5)
    DrawParty()
    ShowMessages()
    cy = cy - 1
    cx = cx - .4
    sx = sx - 2
    sy = sy - 4
    alpha = alpha - .2
until cy<-200 or cx<-100
SetFont("CombatMessage")
for i=0,1000 do
    Image.Tile(starfield,sx,sy)
    Image.SetAlphaPC(alpha)
    Image.Color(0,200,255)
    Image.Rect(0,0,800,600)
    Image.SetAlphaPC()
    DrawParty()
    ShowMessages()
    sx = sx - 2
    sy = sy - 4
    alpha = alpha - .2
    Image.Color(255,180,0)
    if i>400 then Image.DText("Bye!",200,200) end
    if i>750 then Image.DText("Bye!",300,300) end
    end
AblSpecialEffect.RemoveEnemy(ag,ai,tg,ti,act)                    
return true   
end

-- The reason for putting the Muenchhausen graphical effect in a SpecialEffect in stead of a SpellAni (as it is strictly speaking the latter) is because the animation should only play if the ability actually hit.
-- Meaning that if you use it on bosses (who are all immune to it) or if Crystal simply misses the mark you won't see this animation.
