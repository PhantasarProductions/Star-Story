--[[
/* 
  Combat - Target Info

  Copyright (C) 2015 Jeroen P. Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
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

*/



Version: 15.07.27

]]
function AVGLevel(group,chat)
local total=0
local ret
local count=0
for k,v in pairs(Fighters[group]) do
    count = (count or 0) + 1
    total = total + RPGStat.Stat(v.Tag,"Level")
    end
if count==0 then return 0 end    
ret = round(total/count) 
if chat then
   CSay("Average for group: "..group)
   CSay("Total level: "..total)
   CSay("Count: "+count)
   CSay("Average: "+ret)
   end
return ret   
end

function LvlCol(group,i)
if group=="Hero" then return 255,255,255 end
local hlvl = AVGLevel("Hero")
local flvl = RPGStat.Stat(Fighters[group][i].Tag,"Level")
local dlvl = hlvl-flvl
if dlvl>=-2 and dlvl<=2 then return 255,255,255 end
if dlvl>=-4 and dlvl<=0 then return 255,180,  0 end
if dlvl>=-6 and dlvl<=0 then return 255, 80,  0 end
if              dlvl<=0 then return 255,  0,  0 end
if dlvl<= 4 and dlvl>=0 then return 180,255,  0 end
if dlvl<= 6 and dlvl>=0 then return   0,255,  0 end
return 100,100,100
end

function LvString(group,i)
local ret =  "Lv. "..RPGStat.Stat(Fighters[group][i].Tag,"Level").." "
if skill==1 or group=="Hero" then return ret end
if skill==3 then return "" end
local hlvl = AVGLevel("Hero")
local flvl = RPGStat.Stat(Fighters[group][i].Tag,"Level")
local dlvl = flvl-hlvl
if dlvl>8 then return "Lv. ?? " end
return ret
end

function TargetInfo(group,idx,data,x,y)
local GroupColor = { Hero = {0,255,0}, Foe = {255,0,0} }
local c = GroupColor[group]
local cx = x + 10
local cy = y - 20
local cw = 100
local tag= data.Tag --RPGStat.Tag(group,idx)
local lv = LvString(group,idx)
local nm = RPGStat.GetName(tag)
-- Prepare width for enemy name + level
SetFont("StatusBar")
if Image.TextWidth(lv..nm)>cw then cw = Image.TextWidth(lv..nm) end
-- Prepare for extra move + target for under the bar
-- adept cx if the text would be too long
if cx+cw>795 then cx = 795 - cw end 
-- Show all of our shit :)
DarkText(lv,cx,cy,0,0,LvlCol(group,idx))
DarkText(nm,cx+Image.Textwidth(lv),cy,0,0,c[1],c[2],c[3]); cy = cy + Image.TextHeight(nm)
if skill==3 then return end -- In the hard mode, no more information than this :-P
Image.NoFont()
Black()
Image.Rect(cx,cy,cw,Image.TextHeight("?"))
local show = true
local hp  = RPGChar.Points(tag,"HP").Have
local hpm = RPGChar.Points(tag,"HP").Maximum
local r,g,b
if show then
   g = round((hp/hpm)*255)
   b = 0
   r = 255-g
   Image.Color(r,g,b)
   Image.Rect(cx+1,cy+1,((hp/hpm)*(cw-2)),Image.TextHeight("?")-2)
else
   Image.DText("?",cx+(cw/2),cy,2,0)   
   end
end
