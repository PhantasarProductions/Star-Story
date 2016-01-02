--[[
  Bestiary.lua
  Version: 16.01.02
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
imgup   = Image.Load("GFX/Save/Up.png")
imgdown = Image.Load("GFX/Save/Down.png")


function UpdateList()
List = jinc('Script/JINC/Big/BestiaryData.lua')
CSay("Receiving Bestiary Data from Battle Routine")
MS.LoadNew("COMBAT","Script/Flow/Combat.lua")
MS.Run("COMBAT","TransferBestiary")
local get = loadstring(Var.C("$BESTIARYTRANSFER").."\n\nreturn ret")
Var.Clear("$BESTIARYTRANSFER")
Bestiary = get()
if Bestiary then CSay(" = Succes") else CSay(' = Fail'); Sys.Error("Could not retreive Bestiary list") end
Bestiary.BRAINDROID = 0
end


Data = {}
Shown = Shown or {}


function Cancel()
if mousehit(2) then LAURA.Flow("TERMINAL"); end
end

function GetData(foefile)
local paths = {"","Reg/","Boss/","Special/"}
local v,file,checkfile
file = nil
for _,path in ipairs(paths) do
    checkfile = "Script/JINC/Foes/"..path..foefile..".lua"
    -- CSay("Searching for: "..checkfile)
    if JCR6.Exists(checkfile)==1 then file=checkfile end
    end
if not file then Sys.Error(foefile.." not found in any of the allowed directories") end
return JINC(file)
end

function SetShowEnemy(Data,File)
Showing = { Data = Data, File = File }
end

function ShowEnemy()
if not Showing then return end
local paths = {"","Reg/","Boss/","Special/"}
local v,file,checkfile
local maxheight=150
local maxwidth=150
local l,y
if not Showing.Img then
   --[[ old
   file = nil
   for _,path in ipairs(paths) do
       checkfile = "GFX/Combat/Fighters/Foe/"..path..Showing.File..".png"
       -- CSay("Searching for: "..checkfile)
       if JCR6.Exists(checkfile)==1 then file=checkfile end
       end
   if not file then Sys.Error(Showing.File.." not found in any of the allowed directories") end
   Showing.Img=true
   ]]   
   Image.Load("GFX/Combat/Fighters/Foe/"..Showing.Data.ImageFile,"BESTIARY_ENEMY")
   end
if not Showing.Scale then
   Showing.Scale = 100
   if Image.Height("BESTIARY_ENEMY")>maxheight and Image.Height("BESTIARY_ENEMY")>Image.Width("BESTIARY_ENEMY") then Showing.Scale = math.floor((maxheight / Image.Height("BESTIARY_ENEMY"))*100) end
   if Image.Width("BESTIARY_ENEMY")>maxheight and Image.Height("BESTIARY_ENEMY")<=Image.Width("BESTIARY_ENEMY") then Showing.Scale = math.floor((maxheight / Image.Width ("BESTIARY_ENEMY"))*100) end
   CSay("Scaling for "..Showing.File.." set to "..Showing.Scale.."% ("..Image.Width("BESTIARY_ENEMY").."x"..Image.Height("BESTIARY_ENEMY")..")")
   end
White()
Image.ScalePC(Showing.Scale,Showing.Scale)
Image.Draw("BESTIARY_ENEMY",500,20)
Image.ScalePC(100,100)
DarkText(Showing.Data.Name,490+maxwidth,(maxheight/2)+20,0,2,255,0,0)    
Showing.SplitText = Showing.SplitText or mysplit(Showing.Data.Desc,"\n")
y = 40 + maxheight
for l in each(Showing.SplitText) do 
    DarkText(l,480,y,0,0,255,180,0)
    y = y + 20
    end
end

function DrawScreen()
-- Base
White()
Image.Cls()
Image.Show('MenuBack',0,0)
-- Content
Image.ViewPort(80,20,400,400); Image.Color(0,18,25)
Image.Rect    (80,20,400,400)
Image.Origin  (80,20)
local y = 4
PM = PM or 0
local tmx,tmy = MouseCoords()
local mx,my=tmx-80,tmy-20
local allowdown
local foefile
local count,pf 
local hovering,hover
for foefile in each(List) do
    count = nil
    hovering = mx>0 and mx<400 and my>0 and my<400 and my>y-PM and my<(y-PM)+20    
    for pf in each({"","REG/","BOSS/","SPECIAL"}) do if Bestiary[pf..foefile] then count = (count or 0) + Bestiary[pf..foefile] end end
    if not count then
       Red()
       Image.DText("???",4,y-PM,0,0)
    else
       if Shown[foefile] then 
       	  if hovering then Image.Color(255,180,0) else Image.Color(180,100,0) end  
       else 
          if hovering then Image.Color(0,180,255) else Image.Color(0,100,180) end
          end 
       Data[foefile] = Data[foefile] or GetData(foefile)
       Image.DText(Data[foefile].Name,4,y-PM,0,0) -- Actual name comes later
       if hovering and mousehit(1) then SetShowEnemy(Data[foefile],foefile) end
       end
    y = y + 20
    allowdown = y-PM>400    
    end
-- Closure
Image.ViewPort(0,0,800,600)
Image.Origin  (0,0)
local hawk = 'Set to Hawk music'
White()   
if PM>0 then
   Image.Show(imgup,20,20)
   if INP.MouseD(1)==1 and tmy>20 and tmy<20+40 and tmx<90 then PM=PM-1 end
   end
if allowdown then
   Image.Show(imgdown,20,(420)-Image.Height(imgdown))
   if INP.MouseD(1)==1 and tmy>(420-Image.Height(imgdown)) and tmy<420 and tmx<90 then PM=PM+1 end
   end   
-- DarkText("("..tmx..","..tmy..") >> ("..mx..","..my..")",0,0,0,0,180,255,0) -- Debug line only

-- Show the stuff if we got some
ShowEnemy()
-- Party
ShowParty()
-- Mouse
ShowMouse()
end


function MAIN_FLOW()
DrawScreen()
Cancel()
Flip()
end
