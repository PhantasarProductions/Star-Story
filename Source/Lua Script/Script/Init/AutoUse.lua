--[[
/* 
  AutoUse

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



Version: 15.07.20

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
end

function LoadBaseGraphics()
local e,s
CSay("Loading Graphics")
Image.AssignLoad("MOUSE","GFX/CURSOR/Default.PNG")
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
-- Combat menu
for _,s in ipairs({"Bottom","Top","Sides","Item"}) do
    Image.AssignLoad("CMBTM_"..s,"GFX/Combat/PlayerInput/"..s..".png"); CSay("Loaded combat menu asset: "..s)
    end
Image.Hot("CMBTM_Item",Image.Width("CMBTM_Item")/2,0)    
end
