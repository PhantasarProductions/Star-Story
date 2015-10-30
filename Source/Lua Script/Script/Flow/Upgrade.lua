--[[
  Upgrade.lua
  Version: 15.10.30
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
WeaponFiles = {
                    Wendicka = 'Wrench',
                    Crystal  = "Bionic Arm",
                    ExHuRU   = "Claws",
                    Yirl     = "Ray Gun",
                    Foxy     = "Dagger"
              }
WeaponImg = {}              
              
pchar = RPGChar.PartyTag(0)
poschar = 0              

SpecificDraw = {
    
    Weapons = function()
              local y
              local mx,my = MouseCoords()
              local upgrades = CVV("%UPGRADES."..upper(pchar))
              local price
              WeaponImg[pchar] = WeaponImg[pchar] or Image.Load("GFX/Upgrade/"..WeaponFiles[pchar]..".png")
              Image.Show(WeaponImg[pchar])
              SetFont('StatusName')
              DarkText(RPGChar.GetName(pchar),300,15,0,0,255,0,0)
              SetFont('StatusStat')
              for i,v in ipairs ( {"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion"} ) do
                      --Image.Color(0,180,255)
                      y = (i*fonts["StatusStat"][2])+200
                      local r,g,b = 80,80,80
                      DarkText(v,200,y,0,0,0,180,255)
                      DarkText(     RPGStat.Stat(pchar,"BASE_"..v),   400,y,1,0,255,180,0)
                      DarkText("+"..RPGStat.Stat(pchar,"UPGRADE_"..v),500,y,1,0,180,255,0)
                      if upgrades<maxupgrade then
                         price = RPGStat.Stat(pchar,"UPGRADE_"..v) * 125
                         if price==0 then price=250 end
                         if my>y and y<my+fonts["StatusStat"][2] then
                            r,g,b=255,255,255
                            end
                         DarkText('Upgrade',600,y,0,0,r,g,b)
                         DarkText(price.." CR",780,y,1,0,180,0,255)
                         end
                      end
              end,
    ARMS    = function()
              if pchar~="Crystal" then caction=Weapons return end
              end

}


function ShowPartyPoint()
for i=0,5 do
    if ClickedChar(i) and RPGChar.PartyTag(i)~="" then
       if i==poschar then
          LAURA.Flow("FIELD")
       else
          poschar = i
          pchar = RPGChar.PartyTag(i)
          end       
       end
    end
if poschar<3 then
   Image.Color(0,180,255)
	 Image.Draw('MenuCharPointer',(poschar*200)+100,450)
	 end
ShowParty()
if poschar>2 then		
		tpos = poschar - 3
		Image.Color(0,180,255)
		Image.Rect(tpos*40+640,550,30,30,1)
		end		
end	

function DrawScreen()
if not InParty(pchar) then pchar=RPGChar.PartyTag(0) poschar=0 end
Image.Cls(); White()
Image.Show("MenuBack",0,0)
caction = cation or "Weapons"
SpecificDraw[caction]()
ShowPartyPoint()
ShowMouse()
end

function CheckCancel()
if mousehit(2) then LAURA.Flow('FIELD') end
end

function MAIN_FLOW()
DrawScreen()
Flip()
CheckCancel()
end

function GALE_OnLoad()
maxuprade = ngpcount * 10 -- This must live inside this function or the game will crash.
end
