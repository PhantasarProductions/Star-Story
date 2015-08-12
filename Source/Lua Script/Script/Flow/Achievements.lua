--[[
/* 
  Achievements

  Copyright (C) 2015 Jeroen P. Broks

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



Version: 15.08.01

]]
-- @USEDIR Script/GameJolt
achievementscript = true


function GALE_OnLoad()
Achievements = JINC("Script/JINC/Big/Achievements.lua")
Achieved = Achieved or {}
AchIcons = {}
PM=0
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

function Award(PTag)
local Tag = upper(PTag)
if not Achievements[Tag] then Console.Write("ERROR! Achievement '"..Tag.."' does not exist!"); return end
if Achieved[Tag] then return end
CSay("Awarding: "..Tag.." > "..Achievements[Tag].Title)
Achieved[Tag] = true
-- @IF *GAMEJOLT
CSay("Contacting GameJolt")
GJ.Award(GameJoltAchievements[Tag])
-- @FI
Mini('Earned achievement: "'..Achievements[Tag].Title..'"')
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
          DarkText(ach.Title,120,y+30,0,0,dr,dg,db)
          SetFont("AchievementDescription")
          if Achieved[key] then dr=0 dg=180 db=255 else dr=0 dg=90 db=128 end 
          DarkText(ach.Description,120,y+60,0,0,dr,dg,db)
          end
       end 
    end
y = (ca*100)-590    
if my==0   and PM>0 then PM = PM - 2 end
if my>=599 and PM<y then PM = PM + 2 end
if mousehit(2) then 
   if CVV("&ACHTERMIMMEDIATELY") then Sys.Bye() end          
   LAURA.Flow("FIELD") 
   end
if INP.Terminate>0 then 
   if CVV("&ACHTERMIMMEDIATELY") then Sys.Bye() end          
   MS.LoadNew("QUIT","Script/Flow/Quit.lua")
   LAURA.Flow("QUIT") 
   end
ShowMouse()    
Flip()    
end
