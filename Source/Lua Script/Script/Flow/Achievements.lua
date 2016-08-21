--[[
  Achievements.lua
  Version: 16.08.21
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
-- @USEDIR Script/GameJolt
achievementscript = true


function GALE_OnLoad()
Achievements = JINC("Script/JINC/Big/Achievements.lua")
Achieved = Achieved or {}
AchIcons = {}
PM=0
local TReward = {Bronze	= {2,1,1},Silver={3,2,1},Gold={5,3,2},Platinum={10,5,3}}
Reward = { Bronze = 0, Silver=0, Gold=0, Platinum=0}
for aCLASS,aARRAY in pairs(TReward) do 
    Reward[aCLASS] = aARRAY[skill]
    end
end

function GRAB_Achievements(prefix)
local r 
for k,_ in spairs(Achievements) do
    if left(k,len(prefix))==prefix then 
      if r then r=r..";" else r="" end
      r = r .. k
      end
   end
Var.D("$GRABBEDACHIEVEMENTS",r)
return r   
end

function RewardAurinaRate(PTag)
local Tag = upper(PTag)
if not Achievements[Tag] then Console.Write("ERROR! Achievement '"..Tag.."' does not exist!"); return end
if not Achieved[Tag] then return end
local ACLASS = Achievements[Tag]['Type']
inc("%AURINARATE",Reward[ACLASS])
CSay(ACLASS.." Achievement "..Tag.." ("..Achievements[Tag].Title..") rewards: "..Reward[ACLASS].." aurina rate ==> "..CVV("%AURINARATE"))
end

function SyncAurina()
if Done("&AURINASYNCEDTOACHIEVEMENTS") then return end
CSay("Synchronizing Aurina Rate to Achievements you already got")
for t,_ in spairs(Achievements) do RewardAurinaRate(t) end
end

function Award(PTag)
local Tag = upper(PTag)
if not Achievements[Tag] then Console.Write("ERROR! Achievement '"..Tag.."' does not exist!"); return end
if Achieved[Tag] then return end
SyncAurina()
CSay("Awarding: "..Tag.." > "..Achievements[Tag].Title)
Achieved[Tag] = true
RewardAurinaRate(Tag)
-- @IF *GAMEJOLT
CSay("Contacting GameJolt")
GJ.Award(GameJoltAchievements[Tag])
-- @FI
-- @IF *ANNA
CSay("Contacting Anna")
Anna.Award(AnnaAchievements[Tag])
-- @FI

Mini('Earned achievement: "'..Achievements[Tag].Title..'"')
end

-- @IF *GAMEJOLT
function SynchronizeGameJolt()
	Console.Write("")
	Console.Write("Synchronizing achievements with GameJolt",180,0,255)
	Console.Show()
	Console.Flip()
	for key,ach in spairs(Achievements) do
		if Achieved[key] then
			Console.Write("= Sending: "..ach.Title,0,180,255)
			Console.Show()
			Console.Flip()
			GJ.Award(GameJoltAchievements[key])
		end
	end
	Console.Write("All done.",255,180,0)
end
-- @FI

-- @IF *ANNA
function SynchronizeAnna()
	Console.Write("")
	Console.Write("Synchronizing achievements with Anna",180,0,255)
	Console.Show()
	Console.Flip()
	for key,ach in spairs(Achievements) do
		if Achieved[key] then
			Console.Write("= Sending: "..ach.Title,0,180,255)
			Console.Show()
			Console.Flip()
			Anna.Award(AnnaAchievements[key])
		end
	end
	Console.Write("All done.",255,180,0)
end
-- @FI


function mousedown(k)
   return INP.MouseD(k)>0
end    

function MAIN_FLOW()
local y
local ak,ach,key
local mx,my = MouseCoords()
achback = achback or Image.Load('gfx/achievementscreen/back.png')
Image.Cls()
ak=0
local c=0
local ca=0
local dr,dg,db
local fs
-- list
Image.ViewPort(0,0,700,600)
for key,ach in spairs(Achievements) do
    c = c + 1
    -- first "or" statements
    allowview = ach.Show == "Always"
    allowview = allowview or (ach.Show=="Achieved" and Achieved[key])
    -- next the New Game+ statements which require "and"
    -- All allowed? Then let's show it!
    if allowview then
       ca = ca + 1
       y = (ak*100) - PM; ak=ak+1
       -- White(); Image.DText(y,0,y); CSay(key.." >> "..ak.." >> "..y) -- Debug Line
       if y>-100 and y < 700 then -- Only show when visible. It's pointless to render things not visible anyway :)
          -- Back       
          if Achieved[key] then White() else Image.Color(128,128,128) end
          Image.Draw(achback,0,y)
          -- Icon
          if ach.Icon=="*DEFAULT*" then ach.TrueIcon = "GFX/Achievements/"..key..".png" else ach.TrueIcon = ach.Icon end
          if JCR6.Exists(ach.TrueIcon)==1 then
             AchIcons[ach.TrueIcon] = AchIcons[ach.TrueIcon] or Image.Load(ach.TrueIcon)
             Image.Hot(AchIcons[ach.TrueIcon],0,Image.Height(AchIcons[ach.TrueIcon]))
             Image.Draw(AchIcons[ach.TrueIcon],0,y+100)
             end           
          -- Text
          SetFont("AchievementHeader")
          if Achieved[key] then dr=255 dg=0 db=0 else dr=128 dg=0 db=0 end          
          while Image.TextWidth(ach.Title)>450 do
            fs = (fs or fonts.AchievementHeader[2]) - 1
            Image.Font("Fonts/"..fonts.AchievementHeader[1],fs)
          end; fs=nil
          DarkText(ach.Title,120,y+30,0,0,dr,dg,db)
          SetFont("AchievementDescription")
          while Image.TextWidth(ach.Description)>450 do
            fs = (fs or fonts.AchievementDescription[2]) - 1
            Image.Font("Fonts/"..fonts.AchievementDescription[1],fs)
          end; fs=nil
          if Achieved[key] then dr=0 dg=180 db=255 else dr=0 dg=90 db=128 end 
          DarkText(ach.Description,120,y+60,0,0,dr,dg,db)
          end
       end 
    end
y = (ca*100)-590    
--if my==0   and PM>0 then PM = PM - 2 end
--if my>=599 and PM<y then PM = PM + 2 end
if mousehit(2) then 
   if CVV("&ACHTERMIMMEDIATELY") then Sys.Bye() end          
   LAURA.Flow("FIELD") 
   end
if INP.Terminate>0 then 
   if CVV("&ACHTERMIMMEDIATELY") then Sys.Bye() end          
   MS.LoadNew("QUIT","Script/Flow/Quit.lua")
   LAURA.Flow("QUIT") 
   end
-- control bar
Image.ViewPort(700,0,100,600)
Image.Color(255,180,0)
Image.Rect(700,0,5,600)
imgup   = imgup   or Image.Load("GFX/Save/Up.png")
imgdown = imgdown or Image.Load("GFX/Save/Down.png")
imgquit = imgquit or Image.Load("GFX/FieldIcons/Quit.png") -- I know this is RAM inefficient, but I DON'T CARE! I just neede a quick fix, ok?
qx = 700
qy = 5
ux = 700
uy = uy or (10 + Image.Height(imgquit))
dx = 700
dy = dy or 600 - (Image.Height(imgdown)+5)
qe = uy
ue = ue or (uy + Image.Height(imgup))
de = 600
Image.Hot (imgup   ,Image.Width(imgup  )/2,0)
Image.Hot (imgdown ,Image.Width(imgdown)/2,0)
Image.Hot (imgquit ,Image.Width(imgquit)/2,0)
Image.Show(imgup   ,ux+50,uy)
Image.Show(imgdown ,dx+50,dy)
Image.Show(imgquit ,qx+50,qy)
if mousedown(1) and mx>700 then
   if my>qy and my<qe then 
      if CVV("&ACHTERMIMMEDIATELY") then Sys.Bye() end          
      LAURA.Flow("FIELD")
   elseif my>uy and my<ue and PM>0 then PM = PM - 2
   elseif my>dy and my<de and PM<y then PM = PM + 2  
   end   
end
-- mouse and back to whole screen   
Image.ViewPort(0,0,800,600)   
ShowMouse()    
Flip()    
end
