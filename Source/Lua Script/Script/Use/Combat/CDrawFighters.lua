--[[
  CDrawFighters.lua
  Version: 15.10.23
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
foec[idx] = {(cnt*70)+40,(i*100)+150}      
end

function CoordsFighter.Foe(idx)
-- return foec[idx][1],foec[idx][2]
if not Fighters.Foe[idx] then CSay("Warning! Nil reported for foe #"..idx); return 0,0 end
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
table.insert(ReportList[tg][ti],{ x=x,y=y-30, m=report, scale=0, timer=100, r=color[1], g=color[2], b=color[3] })
end

function ShowCharReports()
local fi,fg,fgl,f
if not ReportList then return end
for fg,fgl in spairs(ReportList) do for fi,f in pairs(fgl) do
    if #f>0 then
       --Image.Scale(f[1].scale,f[1].scale)
       if round(f[1].scale)>=1 then Image.Font("Fonts/Robotica.ttf",round(f[1].scale)) end
       DarkText(f[1].m,f[1].x,f[1].y,2,2,f[1].r,f[1].g,f[1].b)
       if f[1].scale<15 then f[1].scale = f[1].scale + .5
       elseif f[1].timer>0 and #f<=1 then f[1].timer = f[1].timer -1 
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
data.Pick = data.Pick or "Default"
local pick = data.Pick
if RPGChar.Points(data.Tag,"HP").Have<=0 then pick="Dead" end
local ptag = "COMBAT.HERO."..data.Tag.."."..(pick or "Default")
local Targeted = isorcontains(TargetedGroup,"Hero") and isorcontains(TargetedFighter,idx)
if Image.Loaded(ptag)==0 then -- Load if needed!
   Image.AssignLoad(ptag,"GFX/Combat/Fighters/Hero/"..data.Tag..'.'..pick..".png")
   if JCR6.Exists("GFX/Combat/Fighters/Hero/"..data.Tag..'.'..pick..".hot")==0 then Image.Hot(ptag,Image.Width(ptag)/2,Image.Height(ptag)) end
   CSay("Loaded: "..ptag)
   end
-- if Targeted then TargetedColor() else White() end   
Image.Show(ptag,x,y)   
-- DarkText("HP="..RPGChar.Points(data.Tag,"HP").Have.."; Pick="..pick.."; tag=".. data.Tag.."; ptag="..ptag,x,y,1) -- debug line
end



function DrawFighter.Foe(idx,data)
local pt={}
local myfoe = Fighters.Foe[idx]
if not myfoe then CSay("WARNING! Attemt to access non-existent foe #"..idx) end
pt[ true]="N"
pt[false]="O"
Neg = Neg or {}
local Targeted = isorcontains(TargetedGroup,"Foe") and isorcontains(TargetedFighter,idx)
-- if Targeted then TargetedColor() else White() end
myfoe.DeathScale = myfoe.DeathScale or 100
Image.ScalePC(100,myfoe.DeathScale)   
Image.Show(pt[Neg[idx]==true]..Fighters.Foe[idx].Tag,CoordsFighter.Foe(idx)) -- Neg[idx]==true is used, as the initial value is "nil" and that would cause the game to crash. CoordsFigher.Foe(idx) will return both the x and the y, and the Lua parser will pick that up correctly.
if RPGStat.Points(myfoe.Tag,"HP").Have==0 then
   myfoe.DeathScale = myfoe.DeathScale - 2
   if myfoe.DeathScale<=0 then
       KillFoe(idx,myfoe) 
       end
   end
Image.ScalePC(100,100)   
end

function FlashFoe(idx,act)
local myfoe = Fighters.Foe[idx]
local k
for k=1,5 do
    Neg = Neg or {}
    Neg[idx] = not Neg[idx]
    DrawScreen()
    Flip()
    Time.Sleep(75)
    end
Neg[idx]=nil    
end



function AnimateHero(idx,act)
local myhero = Fighters.Hero[idx]
local poses = {
        Attack = function()
                 -- MINI("Hero attack pose not yet implemented!",180,255,0) 
                 Fighters.Hero[idx].Pick="Attack.1"
                 for ak=1,25 do
                     DrawScreen()
                     Flip()
                     end
                 Fighters.Hero[idx].Pick="Attack.2"
                 for ak=1,15 do
                     DrawScreen()
                     Flip()
                     end
                 end,
        Cast   = function()
                 Fighters.Hero[idx].Pick="Cast"
                 for ak=1,50 do
                     DrawScreen()
                     Flip()
                     end
                 end, 
        ARM =    function()
                 SFX("Audio/SFX/Crystal ARM.ogg") 
                 Fighters.Hero[idx].Pick="ARM"
                 for ak=1,50 do
                     DrawScreen()
                     Flip()
                     end
                 end         
   }   
-- CSay(serialize("ACT",act))   
;(({
     ATK = poses.Attack,
     SHT = poses.Attack,
     RLD = poses.Cast,
     ITM = poses.Cast,
     ABL = poses[(act.Item or { ABL_Pose="Cast"}).ABL_Pose or 'Cast'], -- Crash prevention when we don't have an ability but another kind of move.
     LRN = poses[(act.Item or { ABL_Pose="Cast"}).ABL_Pose or 'Cast'],
     ARM = poses.ARM
    })[act.Act] or function() MINI("WARNING! Unknown act! I don't know how to animate the hero (Action "..idx..":"..sval(act.Act)..")",255,180,0) MINI("Please report this in the bug tracker if somebody didn't do this before!",255,0,180) MINI("And don't forget to mention the action code above!",255,0,180) end)()   
end

SpriteAnim = {
    Foe = FlashFoe,
    Hero = AnimateHero
    }

function DrawFighters()
local Targeted 
for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        Targeted = isorcontains(TargetedGroup,ft) and isorcontains(TargetedFighter,fli)
        if Targeted then TargetedColor() else White() end
        for stc in iStatusChange(fv.Tag) do
            (StatusDrawFighter[stc] or function() end)(ft,fli)
            end
        DrawFighter[ft](fli,fv)
        end
    end
end
