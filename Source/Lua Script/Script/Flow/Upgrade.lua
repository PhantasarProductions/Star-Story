--[[
  Upgrade.lua
  Version: 16.08.07
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
WeaponFiles = {
                    Wendicka = 'Wrench',
                    Crystal  = "Bionic Arm",
                    ExHuRU   = "Claws",
                    Yirl     = "Ray Gun",
                    Foxy     = "Dagger",
                    Xenobi   = "Light Saber",
                    Rolf     = "Knuckles"
              }
              
WeaponImg = {} 

ARMStat = { HIT = "Accuracy", WEIGHT = "Weight", XPOWER = "Extra Power", AMMO = "Max Ammo"}  
ARMBase = { HIT = "Hit%" , WEIGHT="Weight", AMMO="MaxAmmo", XPOWER="XPower"}        
ARMMax = {HIT=100}   
              
pchar = RPGChar.PartyTag(0)
poschar = 0              

SpecificDraw = {
    
    Weapons = function()
              local y
              local mx,my = MouseCoords()
              local upgrades = CVV("%UPGRADES."..upper(pchar))
              local price
              local r,g,b
              local pricecap = 200000 * (4-skill)
              SetFont('StatusStat')
              DarkText("Upgrades done: "..upgrades.." / "..maxupgrade,400,180,2,1,255,0,180)
              for i,v in ipairs ( {"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion"} ) do
                      --Image.Color(0,180,255)
                      y = (i*fonts["StatusStat"][2])+200
                      r,g,b = 80,80,80
                      DarkText(v,200,y,0,0,0,180,255)
                      DarkText(     RPGStat.Stat(pchar,"BASE_"..v),   400,y,1,0,255,180,0)
                      DarkText("+"..RPGStat.Stat(pchar,"UPGRADE_"..v),500,y,1,0,180,255,0)
                      price = RPGStat.Stat(pchar,"UPGRADE_"..v) * 125
                      if price==0 then price=250 end
                      if upgrades<maxupgrade and price<=pricecap then
                         if my>y and my<y+fonts["StatusStat"][2] then
                            r,g,b=255,255,255
                            if upgrades<maxupgrade and price<=CVV('%CASH') and price<=pricecap and mousehit(1) then
                               SpendMoney(price)
                               SFX("Audio/SFX/Shopping/ChaChing.ogg")
                               RPGStat.IncStat(pchar,"UPGRADE_"..v)
                               inc("%UPGRADES."..upper(pchar))
                               if pchar=='Rolf' then Var.D('%UPGRADES.EXHURU',Var.C('%UPGRADES.ROLF')) end
                               if pchar=='ExHuRU' then Var.D('%UPGRADES.ROLF',Var.C('%UPGRADES.EXHURU')) end
                               end
                            end
                         if price<=CVV('%CASH') then DarkText('Upgrade',520,y,0,0,r,g,b) end
                         DarkText(price.." CR",780,y,1,0,180,0,255)
                         end
                      end
              end,
    ARMS    = function()
              if pchar~="Crystal" then caction=Weapons return end
              local abilities = RPGStat.CountList(pchar,"ARMS")
              local ARM,ARMName              
              local y,r,g,b
              local mx,my = MouseCoords()
              local allow,statname,statval
              -- local pchar = "Crystal"
              local pricecap = 100000 * (4-skill)-- I want to prevent Lua going haywire because of too high values.
              SetFont('StatusStat')
              for i=1,abilities do
                  y = (i*fonts["StatusStat"][2])+160
                  ARMName = RPGStat.ListItem(pchar,"ARMS",i)
                  ARM = ItemGet("ARM_"..ARMName)
                  DarkText(Var.S(ARM.Name),70,y,0,0,({[true]=function() return 0,180,255 end, [false]=function() return 0,80,100 end})[ARMName==cARM]())
                  if mx<300 and my>y and my<y+fonts["StatusStat"][2] and mousehit(1) then cARM=ARMName end
                  end
              if cARM then
                 y = 200
                 ARM = ItemGet("ARM_"..cARM)
            		 if RPGChar.Points(pchar,"ARM.AMMO."..cARM,1).Maximum == 0 then RPGChar.Points(pchar,"ARM.AMMO."..cARM,1).Maximum = ARM["ARM_MaxAmmo"] end
             		 if RPGChar.StatExists(pchar,"ARM.HIT."..cARM)==0 then RPGChar.DefStat(pchar,"ARM.HIT."..cARM,ARM["ARM_Hit%"]) end
                 if RPGChar.StatExists(pchar,"ARM.WEIGHT."..cARM)==0 then RPGChar.DefStat(pchar,"ARM.WEIGHT."..cARM,ARM["ARM_Weight"]) end
                 if RPGChar.StatExists(pchar,"ARM.XPOWER."..cARM)==0 then RPGChar.DefStat(pchar,"ARM.XPOWER."..cARM,ARM["ARM_XPower"]) end
                 for id,stat in spairs(ARMStat) do
                      -- Make sure all data is properly set up. Fixes #456
                      DarkText(stat,300,y,0,0,0,180,255) ;
                      (({ AMMO = function() DarkText(RPGChar.Points(pchar,"ARM.AMMO."..cARM).Maximum,500,y,1,0,180,255,0) end,
                          WEIGHT = function() DarkText("-"..RPGChar.Stat(pchar,"ARM.WEIGHT."..cARM),500,y,1,0,180,255,0) end,
                          HIT = function() DarkText(RPGChar.Stat(pchar,"ARM.HIT."..cARM).."%",500,y,1,0,180,255,0) end
                           })[id] or function() DarkText(RPGChar.Stat(pchar,"ARM."..id.."."..cARM),500,y,1,0,180,255,0) end)()
                      allow = true
                      statname = "ARM."..cARM..".PRICE."..id
                      if RPGChar.StatExists(pchar,statname)==0 then 
                         RPGChar.DefStat(pchar,statname,ARM['ARM_PRICE_'..ARMBase[id]])
                         CSay("Pricing "..cARM.." part "..id.." to ".. sval(ARMBase[ARM['ARM_PRICE_'..id]])) 
                         end -- This will put in the price inside Crystal's record, but only if that record is still empty.                      
                      statval = RPGChar.Stat(pchar,statname)
                      allow = allow and statval>0
                      allow = allow and statval<=pricecap
                      allow = allow and (id=="AMMO" or ((not ARMMax[id]) or RPGChar.Stat(pchar,"ARM."..id.."."..cARM)<ARMMax[id]))
                      if allow then DarkText(statval.." CR",780,y,1,0,180,0,255) end
                      allow = allow and CVV("%CASH")>=statval
                      r,g,b=80,80,80
                      if allow then
                         if mx>400 and my>y and my<y+fonts["StatusStat"][2] then
                            r,g,b=255,255,255
                            if mousehit(1) then
                               SpendMoney(statval)
                               SFX("Audio/SFX/Shopping/ChaChing.ogg")
                               if id=="AMMO" then
                                 RPGChar.Points(pchar,"ARM.AMMO."..cARM).Maximum = RPGChar.Points(pchar,"ARM.AMMO."..cARM).Maximum + 1 
                                 RPGChar.Points(pchar,"ARM.AMMO."..cARM).Have = RPGChar.Points(pchar,"ARM.AMMO."..cARM).Maximum
                               else
                                 RPGStat.IncStat(pchar,"ARM."..id.."."..cARM,4-skill)
                                 if ARMMax[id] and RPGStat.Stat(pchar,"ARM."..id.."."..cARM)>ARMMax[id] then RPGStat.DefStat(pchar,"ARM."..id.."."..cARM,ARMMax[id]) end
                                 end
                               RPGStat.IncStat(pchar,statname,statval)  
                               end                               
                            end                 
                         DarkText("Upgrade",520,y,0,0,r,g,b)              
                         end -- allow
                      y = y + fonts["StatusStat"][2]    
                      end -- for
                 end -- cARM
              end -- function

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
local mx,my = MouseCoords()
if not InParty(pchar) then pchar=RPGChar.PartyTag(0) poschar=0 end
Image.Cls(); White()
Image.Show("MenuBack",0,0)
WeaponImg[pchar] = WeaponImg[pchar] or Image.Load("GFX/Upgrade/"..WeaponFiles[pchar]..".png")
Image.Show(WeaponImg[pchar])
SetFont('StatusName')
DarkText(RPGChar.GetName(pchar),300,15,0,0,255,0,0)
if pchar=="Crystal" then
   for i,gofor in ipairs({"Weapons","ARMS"}) do
       DarkText(gofor,i*200,125,2,2,({[true]=function() return 0,180,255 end, [false]=function() return 0,80,100 end})[gofor==caction]()) -- What? Ugly code? I did prevent an "if" didn't I?
       if my>100 and my<150 and mx>(i*200)-100 and mx<(i*200)+100 and mousehit(1) then caction=gofor end -- Okay, this time I didn't, makes you able to compare what looks better! :-P       
       end
   end
caction = caction or "Weapons"
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
maxupgrade = ngpcount * 10 -- This must live inside this function or the game will crash.
end
