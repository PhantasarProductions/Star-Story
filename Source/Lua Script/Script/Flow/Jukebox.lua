--[[
  Jukebox.lua
  Version: 16.08.29
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
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

playing = nil

imgup   = Image.Load("GFX/Save/Up.png")
imgdown = Image.Load("GFX/Save/Down.png")


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
local removesongs = {}
local allowdown
if not Songs then
   Songs = JINC('Script/JINC/Big/JukeBoxData.lua')
   for title,data in spairs(Songs) do
       if JCR6.Exists(data.File)==0 then removesongs[#removesongs+1]=title end
       end
   for title in each(removesongs) do Songs[title] = nil end -- Songs for the full version removed if this is the demo. 
   end
for title,data in spairs(Songs) do
    SetFont('Terminal')
    if mx>0 and mx<400 and my>y-PM and my<(y-PM)+20 then
       Image.Color(0,180,255)
       if mousehit(1) then 
          playing = data
          data.Title=title
          Music(data.File) 
          end
    else
       Image.Color(0,100,180)
       end
    Image.DText(title,4,y-PM)
    y = y + 20    
    allowdown = y-PM > 400  
    end
Image.ViewPort(0,0,800,600)
Image.Origin  (0,0)
local hawk = 'Set to Hawk music'
if playing then
   Image.Color(255,0,0)
   Image.DText("Playing:",780,20,1,0)
   Image.DText("Artist:",780,70,1,0)
   Image.Color(255,180,0)
   Image.DText(playing.Title,780,40,1,0)
   Image.DText(playing.Artist,780,90,1,0)
   if tmx>780-Image.TextWidth(hawk) and tmy>350 and tmy<400 then
      Image.Color(180,255,0)
      if mousehit(1) then Var.D("$HAWKMUSIC",playing.File) end
      else
      Image.Color(100,180,0)
      end
   Image.DText(hawk,780,350,1,0)   
   end
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

-- Party
ShowParty()
-- Mouse
ShowMouse()
end


function Cancel()
if mousehit(2) then LAURA.Flow("TERMINAL"); playing=nil MS.Run('MAP',"HawkMusic") end
end

function MAIN_FLOW()
DrawScreen()
Cancel()
Flip()
end
