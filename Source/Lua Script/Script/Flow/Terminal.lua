--[[
  Terminal.lua
  Version: 15.10.27
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
-- @USEDIR Script/Use/Maps/Hawk_Terminal/
back = "MenuBack"

Menu = {

         Save = {
                   Action = GotoSave,   
                   AllowAlways = true                
                }
       }

function DrawScreen()
-- First the background
Image.Show(back,0,0)
-- Draw all the apps
local x = 40
local y = 40
local mx,my = MouseCoords()
for idx,item in spairs(Menu) do
    if item.AlwaysAllow or CVV(SysVar) then
       if mx>x-32 and mx<x+32 and my>y-32 and my<y+55 then
          Image.Color(0,180,255)
          if mousehit(1) then item.Action() end
       else
          Image.Color(0,100,255)
          end
       Image.Show(item.Icon)
       Image.DText(idx,x,y+40,2,0)
       end
    end
-- Lastly the party and the mouse
ShowParty()
ShowMouse()
end

function CheckExit()
if mousehit(2) then LAURA.Flow("FIELD") end
end

function MAIN_FLOW()
DrawScreen()
CheckExit()
Flip()
end

function GALE_OnLoad()
for idx,item in spairs(Menu) do
    CSay("Loading App: ")
    item.Icon = Image.Load("GFX/Terminal/"..idx..".png")
    Image.HotCenter(item.Icon)
    end
end
