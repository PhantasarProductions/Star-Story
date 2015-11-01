--[[
  AutoUse.lua
  Version: 15.11.01
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
-- @USEDIR Script/Use/Anyway

Image.SetAlphaBlend()

function LoadFlowsScripts()
CSay("Loading Flow Scripts")
-- Subroutines
MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
MS.LoadNew("BOXTEXT.KTHURA","Script/SubRoutines/BoxTextKthuraBackGround.lua")
MS.LoadNew("MUSIC","Script/SubRoutines/TrueMusic.lua")
MS.LoadNew("PARTY","Script/SubRoutines/Party.lua")
-- Flow
MS.LoadNew("FIELD","Script/Flow/Field.lua")
-- Make sure BoxText has a few core setups loaded
MS.Run("BOXTEXT","LoadData","GENERAL/SCOTTY;SCOTTY")
MS.Run("BOXTEXT","LoadData","GENERAL/ARMS;ARMS")
MS.Run("BOXTEXT","LoadData","GENERAL/SECRETDUNGEON;SECRETDUNGEON")
end

function LoadBaseGraphics()
local e,s
CSay("Loading Graphics")
Image.AssignLoad("MOUSE","GFX/CURSOR/Default.PNG")
Image.AssignLoad("COLPT","GFX/CURSOR/Collision.PNG") -- This picture will NEVER be shown, only be used for collision checks.
Image.AssignLoad("COMBATGAUGE","GFX/Combat/TimeGauge.png")
Image.AssignLoad("COMBATGAUGEPOINTHERO","GFX/Combat/HeroTimePointer.png");  Image.Hot("COMBATGAUGEPOINTHERO",10,45)
Image.AssignLoad("COMBATGAUGEPOINTFOE" ,"GFX/Combat/FoeTimePointer.png");   Image.Hot("COMBATGAUGEPOINTFOE", 10, 0)
-- Element icons
for _,e in ipairs(ElementList) do
    Image.AssignLoad("ELEMICON_"..e,"GFX/Elements/"..e..".png")
    CSay("Loaded Elemental Icon: "..e)
    end
-- Status icons
local sdir = "GFX/STATUSCHANGES/"
local sf
for s in iJCR6Dir(true) do -- The "true" will return all filenames in CAPS
    if left(s,len(sdir))==sdir and right(s,4)==".PNG" then
       sf = Str.Replace(s , sdir ,"")
       sf = Str.Replace(sf,".PNG","")
       Image.AssignLoad("STATUS_"..sf,s)
       CSay("Status Icon Loaded: "..sf)
       end
    end    
-- General menu
Image.AssignLoad("MenuBack","GFX/StatusBar/StatusFull.png")    
Image.AssignLoad("MenuCharPointer","GFX/StatusBar/CharPointer.png");
-- Combat menu
for _,s in ipairs({"Bottom","Top","Sides","Item"}) do
    Image.AssignLoad("CMBTM_"..s,"GFX/Combat/PlayerInput/"..s..".png"); CSay("Loaded combat menu asset: "..s)
    end
Image.Hot("CMBTM_Item",Image.Width("CMBTM_Item")/2,0)    
-- Ability Power Ups
for pu in each(ABL_PowerUps) do
    Image.AssignLoad("ABL_"..pu,"GFX/StatusBar/AbilityPowerup/"..pu..".png")
    CSay("Loaded icon for ability power up: "..pu)
    Image.HotCenter("ABL_"..pu)
    end
Image.AssignLoad("ABL_Socket","GFX/StatusBar/AbilityPowerup/Socket.png")
Image.HotCenter("ABL_Socket")    
end
