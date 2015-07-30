--[[
/* 
  Draw Fighters

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
DrawFighter = {}
CoordsFighter = {}

function CoordsFighter.Hero(idx)
local x = (idx* 50)+600
local y = (idx*100)+150
return x,y
end 

function InitFoeCoords(idx)
local cnt=0
local i=idx
while i>3 do
      cnt=cnt+1
      i=i-3
      end
foec = foec or {}
foec[idx] = {(cnt*50)+30,(i*100)+150}      
end

function CoordsFighter.Foe(idx)
-- return foec[idx][1],foec[idx][2]
return Fighters.Foe[idx].x,Fighters.Foe[idx].y
end

function FighterCoords(g,t)
return CoordsFighter[g](t)
end 

function CharReport(tg,ti,report,color)
ReportList         = ReportList         or {}
ReportList[tg]     = ReportList[tg]     or {}
ReportList[tg][ti] = ReportList[tg][ti] or {}
local x,y = FighterCoords(tg,ti)
table.insert(ReportList[tg][ti],{ x=x,y=y, m=report, scale=0, timer=100, r=color[1], g=color[2], b=color[3] })
end

function ShowCharReports()
local fi,fg,fgl,f
if not ReportList then return end
for fg,fgl in spairs(ReportList) do for fi,f in pairs(fgl) do
    if #f>0 then
       --Image.Scale(f[1].scale,f[1].scale)
       Image.Font("Robotica.ttf",round(f[1].scale))
       DarkText(f[1].m,f[1].x,f[1].y,2,2,f[1].r,f[1].g,f[1].b)
       if f[1].scale<15 then f[1].scale = f[1].scale + .5
       elseif f[1].timer>0 then f[1].timer = f[1].timer -1 
       else table.remove(f,1) end
       end
    end end
--Image.Scale(1,1)    
end

function TargetedColor()
--[[ No good
TAR_HueChange  = 1
TAR_Hue        = TAR_Hue or 0
TAR_Saturation = TAR_Saturation or 0
TAR_SatChange  = TAR_SatChange or 2
TAR_Value      = 255
TAR_Saturation = TAR_Saturation + TAR_SatChange
if TAR_Saturation >= 100 then 
  TAR_SatChange=-2 
elseif TAR_Saturation<=0 then 
  TAR_SatChange=2; 
  TAR_Hue=TAR_Hue+TAR_HueChange 
  end
if TAR_Hue>=340 then TAR_Hue=0 end
Image.ColorHSV(TAR_Hue,TAR_Saturation,TAR_Value)
-- CSay(TAR_Hue,Tar_Saturation,TAR_Value) -- Debug line
DarkText(TAR_Hue..","..TAR_Saturation..","..TAR_Value.."   SC="..TAR_SatChange,400,300,2,2)
--]]
TAR_Col = TAR_Col or {255,255,255}
TAR_ChgTable = { {true,false,false}, {false,true,false}, {false,false,true}, {true,true,false}, {false,true,true}, {true,false,true} }
TAR_ChgIdx = TAR_ChgIdx or rand(1,#TAR_ChgTable)
TAR_Value = TAR_Value or 255
TAR_Chg = TAR_Chg or -2
TAR_Value = TAR_Value + TAR_Chg
for ak=1,3 do
    if TAR_ChgTable[TAR_ChgIdx][ak] then TAR_Col[ak]=TAR_Value else TAR_Col[ak]=255 end
    end
if TAR_Value<=0 then
  TAR_Chg = 2
elseif TAR_Value>=255 then
  TAR_Chg = -2
  TAR_ChgIdx = rand(1,#TAR_ChgTable)
  end
Image.Color(TAR_Col[1],TAR_Col[2],TAR_Col[3])
end


function DrawFighter.Hero(idx,data)
local x,y = CoordsFighter.Hero(idx)
-- Marker(x,y)
local ptag = "COMBAT.HERO."..data.Tag.."."..(data.Pick or "default")
local Targeted = isorcontains(TargetedGroup,"Hero") and isorcontains(TargetedFighter,idx)
data.Pick = data.Pick or "Default"
if Image.Loaded(ptag)==0 then -- Load if needed!
   Image.AssignLoad(ptag,"GFX/Combat/Fighters/Hero/"..data.Tag..'.'..data.Pick..".png")
   if JCR6.Exists("GFX/Combat/Fighters/Hero/"..data.Tag..'.'..data.Pick..".hot")==0 then Image.Hot(ptag,Image.Width(ptag)/2,Image.Height(ptag)) end
   CSay("Loaded: "..ptag)
   end
if Targeted then TargetedColor() else White() end   
Image.Show(ptag,x,y)   
end



function DrawFighter.Foe(idx,data)
local pt={}
pt[ true]="N"
pt[false]="O"
Neg = Neg or {}
local Targeted = isorcontains(TargetedGroup,"Foe") and isorcontains(TargetedFighter,idx)
if Targeted then TargetedColor() else White() end   
Image.Show(pt[Neg[idx]==true]..Fighters.Foe[idx].Tag,CoordsFighter.Foe(idx)) -- Neg[idx]==true is used, as the initial value is "nil" and that would cause the game to crash. CoordsFigher.Foe(idx) will return both the x and the y, and the Lua parser will pick that up correctly. 
end


function DrawFighters()
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        DrawFighter[ft](fli,fv)
        end
    end
end
